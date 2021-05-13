// Q1
MATCH (user:User)-[:POSTED]->(tweet:Tweet{month:"1",year:"2016"})
RETURN tweet.retweet_count, tweet.text,user.screen_name,user.category,user.sub_category
ORDER BY toInteger(tweet.retweet_count) DESC
LIMIT 5

//Q2
MATCH(hashtag:Hashtag)-[:TAGGED]->(tweet:Tweet{year:"2016"})<-[:POSTED]-(user:User)-[:FROM]->(state:State)
where NOT state.name="na" AND NOT hashtag.name=""
WITH count(DISTINCT state.name) as counter, collect(DISTINCT state.name)as stateList,hashtag
ORDER BY counter DESC
LIMIT 5
RETURN counter, stateList, hashtag.name

//Q3
MATCH(hashtag:Hashtag)-[:TAGGED]->(tweet:Tweet)<-[:POSTED]-(user:User)-[:FROM]->(state:State)
WHERE hashtag.name = "HappyNewYear"or hashtag.name="NewYear"or hashtag.name="NewYears"or hashtag.name="NewYearsDay"
WITH distinct user, state, toInteger(user.followers) as numF
ORDER By numF desc limit 12
RETURN distinct user.screen_name,state.name

//Q4
MATCH(user:User{sub_category:"GOP"})
RETURN user.screen_name,user.sub_category,toInteger(user.followers)
ORDER BY toInteger(user.followers) desc limit 5

MATCH(user:User{sub_category:"democrat" })
RETURN user.screen_name,user.sub_category,toInteger(user.followers)
ORDER BY toInteger(user.followers) desc limit 5

//Q5
MATCH(hashtag:Hashtag)-[:TAGGED]->(tweet:Tweet{month:"1",year:"2016"})<-[:POSTED]-(user:User)-[:FROM]->(state:State)
WHERE (state.name = "Ohio" OR state.name = "Alaska" OR state.name = "Alabama")AND NOT hashtag.name = ""
RETURN distinct toUpper(hashtag.name),state.name order by toUpper(hashtag.name)

//Q6
MATCH(hashtag:Hashtag{name:"Ohio"})-[:TAGGED]->(tweet:Tweet{month:"1",year:"2016"})<-[:POSTED]-(user:User)-[:FROM]->(state:State{name:"Ohio"})
WHERE user.sub_category="GOP"OR user.sub_category="democrat"
RETURN tweet.text,hashtag.name,user.screen_name,user.sub_category
LIMIT 5 

//Q7
MATCH(url:Url)-[:URL_USED]-(tweet:Tweet{month:"1",year:"2016"})<-[:POSTED]-(user:User)-[:FROM]->(state:State)
WHERE user.sub_category="GOP"
RETURN user.screen_name,state.name,collect(distinct url.url)

//Q8
MATCH (u:User{sub_category:"GOP"})-[:POSTED] ->(tweet:Tweet{month:"1",year:"2016"})-[:MENTIONED]->(m:User)-[:FROM]->(s:State)
with s,m,count(u.screen_name)as users,collect(DISTINCT toUpper(u.screen_name))as postingUsers
ORDER BY users DESC
LIMIT 5
RETURN m.screen_name,s.name,postingUsers

//Q9
MATCH(hashtag:Hashtag)-[:TAGGED]->(tweet:Tweet)<-[:POSTED]-(user:User)
WHERE user.sub_category="GOP"AND(tweet.month="1"OR tweet.month="2"OR tweet.month="3")AND tweet.year="2016"AND NOT hashtag.name="" 
RETURN DISTINCT(toUPPER(hashtag.name)),count(toUpper(user.screen_name))
ORDER BY count(toUpper(user.screen_name)) DESC
LIMIT 5