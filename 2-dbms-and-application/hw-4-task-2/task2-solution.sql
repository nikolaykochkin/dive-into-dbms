CREATE OR REPLACE FUNCTION SubmitReview(_paper_id INT, _reviewer_id INT, _score INT)
    RETURNS VOID AS
$$
DECLARE
    review_stat             RECORD;
    selected_paperreviewing paperreviewing%ROWTYPE;
    selected_paper          paper%ROWTYPE;
    _accepted               BOOLEAN;
BEGIN
    IF _score > 7 OR _score < 1 THEN
        RAISE SQLSTATE 'DB017';
    END IF;

    SELECT * INTO selected_paperreviewing FROM paperreviewing WHERE paper_id = _paper_id AND reviewer_id = _reviewer_id;
    IF NOT FOUND THEN
        RAISE SQLSTATE 'DB017';
    END IF;

    SELECT * INTO selected_paper FROM paper WHERE id = _paper_id;
    IF NOT FOUND THEN
        RAISE SQLSTATE 'DB017';
    END IF;

    IF selected_paper.accepted IS NULL THEN
        UPDATE paperreviewing SET score = _score WHERE paper_id = _paper_id AND reviewer_id = _reviewer_id;

        SELECT COUNT(*) total, AVG(score) avg_score
        INTO review_stat
        FROM paperreviewing
        WHERE paper_id = _paper_id
          AND score IS NOT NULL;

        IF review_stat.total >= 3 THEN
            _accepted := review_stat.avg_score > 4;
            UPDATE paper SET accepted = _accepted WHERE id = _paper_id;
        END IF;
    ELSE
        RAISE SQLSTATE 'DB017';
    END IF;
END;
$$ LANGUAGE plpgsql;