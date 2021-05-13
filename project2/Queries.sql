
use project2;


/*Q1 */
SELECT  tweet.retweet_count, tweet.text , tweet.posting_user,user.category,user.sub_category
FROM tweet
INNER JOIN user
ON tweet.posting_user = user.screen_name
WHERE month_posted = 1 and year_posted = 2016 ORDER BY retweet_count   desc limit 5;
/*Q1 */

/*Q2 */
SELECT hashtag.hastagname,
count(DISTINCT user.ofstate),
GROUP_CONCAT(DISTINCT user.ofstate  ORDER BY user.ofstate) AS states
FROM hashtag INNER JOIN tweet INNER JOIN user
ON tweet.posting_user = user.screen_name and tweet.tid = hashtag.tid
WHERE year_posted = 2016 AND NOT user.ofstate = "na"
GROUP BY hashtag.hastagname
ORDER BY count(DISTINCT user.ofstate)
desc limit 5;

/*Q2 */

/*Q3 */
SELECT  MIN(tweet.posting_user) AS posting_user,  user.ofstate
FROM hashtag INNER JOIN tweet INNER JOIN user
ON tweet.posting_user = user.screen_name and tweet.tid = hashtag.tid
WHERE hastagname = "HappyNewYear" OR hastagname = "NewYear" OR hastagname ="NewYears" OR hastagname ="NewYearsDay" 
GROUP BY user.ofstate,user.followers ORDER BY user.followers desc limit 12;
/*Q3 */

/*Q4 */
SELECT  screen_name,sub_category,followers
FROM user
WHERE sub_category="GOP"   
ORDER BY followers   desc limit 5;

SELECT  screen_name,sub_category,followers
FROM user
WHERE sub_category ="Democrat"   
ORDER BY followers   desc limit 5;
/*Q4 */

/*Q5 */
SELECT DISTINCT hashtag.hastagname,  user.ofstate
FROM hashtag INNER JOIN tweet INNER JOIN user
ON tweet.posting_user = user.screen_name and tweet.tid = hashtag.tid
WHERE user.ofstate = "Ohio" OR user.ofstate = "Alaska" OR user.ofstate ="Alabama" and month_posted = 1 and year_posted=2016 
GROUP BY hastagname,user.ofstate;
/*Q5 */


/*Q6 */
SELECT   tweet.text , hastagname,tweet.posting_user,user.sub_category
FROM hashtag INNER JOIN tweet INNER JOIN user
ON tweet.posting_user = user.screen_name and tweet.tid = hashtag.tid
WHERE hastagname ="Ohio" and user.ofstate="Ohio" and (sub_category="GOP" or sub_category ="Democrat") and month_posted = 1 and year_posted = 2016   limit 5;
/*Q6 */

/*Q7 */
SELECT   tweet.posting_user,user.ofstate,
GROUP_CONCAT(DISTINCT url.url  ORDER BY url.url)
FROM url INNER JOIN tweet INNER JOIN user
ON tweet.posting_user = user.screen_name and tweet.tid = url.tid
WHERE sub_category="GOP" and month_posted = 1 and year_posted = 2016 
GROUP BY tweet.posting_user;
/*Q7 */

/*Q8 */
SELECT mentioned.screen_name, ofstate,
GROUP_CONCAT(distinct tweet.posting_user  ORDER BY tweet.posting_user) as postingUser
FROM mentioned INNER JOIN tweet INNER JOIN user
ON user.screen_name=tweet.posting_user  and tweet.tid = mentioned.tid
WHERE sub_category="GOP" and month_posted = 1 and year_posted = 2016 
GROUP BY mentioned.screen_name, ofstate
ORDER BY count(tweet.posting_user)desc limit 5;
/*Q8 */


/*Q9 */
SELECT DISTINCT hashtag.hastagname,
count(user.screen_name) as num_uses
FROM hashtag INNER JOIN tweet INNER JOIN user
ON tweet.posting_user = user.screen_name and tweet.tid = hashtag.tid
WHERE sub_category="GOP" and (month_posted = 1 or month_posted = 2 or month_posted = 3)and year_posted = 2016
GROUP BY hashtag.hastagname
ORDER BY num_uses desc limit 5;
/*Q9 */


