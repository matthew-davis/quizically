SELECT a.QUIZ_CURRENT, a.QUIZ_STATUS, b.PART_SCORE, d.QUESTION, d.QUEST_CATEGORY, e.ANS_A, e.ANS_B, e.ANS_C, e.ANS_D, e.ANS_CORRECT
    FROM P_QUIZ a, P_PARTICIPANTS b, P_USERS c, P_QUESTIONS d, P_ANSWERS e
    WHERE a.QUIZ_ID = b.QUIZ_ID
    AND b.USE_ID = c.USE_ID
	AND a.QUEST_ID = d.QUEST_ID
	AND d.QUEST_ID = e.QUEST_ID
	AND a.QUIZ_CODE = ???
    AND c.USE_EMAIL = ???