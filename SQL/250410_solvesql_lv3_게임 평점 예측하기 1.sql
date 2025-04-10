SELECT
  g.game_id AS game_id,
  g.name AS name,
  CASE WHEN g.critic_score IS NULL THEN ROUND(c.critic_score, 3) ELSE g.critic_score END AS critic_score,
  CASE WHEN g.critic_count IS NULL THEN CEIL(c.critic_count) ELSE g.critic_count END AS critic_count,
  CASE WHEN g.user_score IS NULL THEN ROUND(c.user_score, 3) ELSE g.user_score END AS user_score,
  CASE WHEN g.user_count IS NULL THEN CEIL(c.user_count) ELSE g.user_count END AS user_count
FROM games AS g
  INNER JOIN (
    SELECT 
      genre_id, 
      AVG(critic_score) AS critic_score,
      AVG(critic_count) AS critic_count,
      AVG(user_score) AS user_score,
      AVG(user_count) AS user_count
    FROM games
    GROUP BY genre_id) AS c
  ON g.genre_id = c.genre_id
WHERE g.year >= 2015
  AND (
    g.user_count IS NULL 
    OR g.user_score IS NULL
    OR g.critic_count IS NULL
    OR g.critic_score IS NULL
  );