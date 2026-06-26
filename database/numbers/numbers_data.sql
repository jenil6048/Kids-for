-- 1. Create numbers table and index

CREATE TABLE IF NOT EXISTS public.numbers (
  id bigint generated always as identity not null,
  topic_key text not null,
  category_id bigint null,
  name jsonb not null default '{}'::jsonb,
  svg_path text null,
  image_path text null,
  lottie_path text null,
  narration jsonb not null default '{}'::jsonb,
  explanation jsonb not null default '{}'::jsonb,
  fact jsonb not null default '{}'::jsonb,
  game_type text null,
  is_free boolean not null default true,
  display_order integer null,
  constraint numbers_pkey primary key (id),
  constraint numbers_topic_key_key unique (topic_key),
  constraint numbers_category_id_fkey foreign KEY (category_id) references categories (id) on delete CASCADE
) TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS idx_numbers_topic_key on public.numbers using btree (topic_key) TABLESPACE pg_default;

ALTER TABLE public.numbers DISABLE ROW LEVEL SECURITY;

GRANT ALL ON public.numbers TO anon;
GRANT ALL ON public.numbers TO authenticated;
GRANT ALL ON public.numbers TO service_role;


-- 2. Populate numbers table with 100 numbers data

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '1', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "1", "gu": "1", "hi": "1"}'::jsonb, 
  '/assets/svgs/numbers/1.svg', 
  '{"en": "One! Let''s count 1 Apple.", "gu": "એક! ચાલો એક સફરજન ગણીએ!", "hi": "एक! आइए एक सेब गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Apple on this card? Counting Apple is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા સફરજન શોધી શકો છો? સફરજન ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी सेब पा सकते हैं? सेब गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 1. It represents 1 items.", "gu": "આપણે આ સંખ્યાને 1 તરીકે લખીએ છીએ. તે 1 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 1 के रूप में लिखते हैं। यह 1 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  1
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '2', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "2", "gu": "2", "hi": "2"}'::jsonb, 
  '/assets/svgs/numbers/2.svg', 
  '{"en": "Two! Let''s count 2 Stars.", "gu": "બે! ચાલો બે તારા ગણીએ!", "hi": "दो! आइए दो तारे गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Stars on this card? Counting Stars is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા તારા શોધી શકો છો? તારા ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी तारे पा सकते हैं? तारे गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 2. It represents 2 items.", "gu": "આપણે આ સંખ્યાને 2 તરીકે લખીએ છીએ. તે 2 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 2 के रूप में लिखते हैं। यह 2 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  2
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '3', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "3", "gu": "3", "hi": "3"}'::jsonb, 
  '/assets/svgs/numbers/3.svg', 
  '{"en": "Three! Let''s count 3 Balloons.", "gu": "ત્રણ! ચાલો ત્રણ ફુગ્ગાઓ ગણીએ!", "hi": "तीन! आइए तीन गुब्बारे गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Balloons on this card? Counting Balloons is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા ફુગ્ગાઓ શોધી શકો છો? ફુગ્ગાઓ ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी गुब्बारे पा सकते हैं? गुब्बारे गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 3. It represents 3 items.", "gu": "આપણે આ સંખ્યાને 3 તરીકે લખીએ છીએ. તે 3 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 3 के रूप में लिखते हैं। यह 3 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  3
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '4', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "4", "gu": "4", "hi": "4"}'::jsonb, 
  '/assets/svgs/numbers/4.svg', 
  '{"en": "Four! Let''s count 4 Bubbles.", "gu": "ચાર! ચાલો ચાર પરપોટા ગણીએ!", "hi": "चार! आइए चार बुलबुले गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Bubbles on this card? Counting Bubbles is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા પરપોટા શોધી શકો છો? પરપોટા ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी बुलबुले पा सकते हैं? बुलबुले गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 4. It represents 4 items.", "gu": "આપણે આ સંખ્યાને 4 તરીકે લખીએ છીએ. તે 4 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 4 के रूप में लिखते हैं। यह 4 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  4
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '5', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "5", "gu": "5", "hi": "5"}'::jsonb, 
  '/assets/svgs/numbers/5.svg', 
  '{"en": "Five! Let''s count 5 Hearts.", "gu": "પાંચ! ચાલો પાંચ દિલ ગણીએ!", "hi": "पाँच! आइए पाँच दिल गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Hearts on this card? Counting Hearts is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા દિલ શોધી શકો છો? દિલ ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी दिल पा सकते हैं? दिल गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 5. It represents 5 items.", "gu": "આપણે આ સંખ્યાને 5 તરીકે લખીએ છીએ. તે 5 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 5 के रूप में लिखते हैं। यह 5 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  5
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '6', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "6", "gu": "6", "hi": "6"}'::jsonb, 
  '/assets/svgs/numbers/6.svg', 
  '{"en": "Six! Let''s count 6 Candies.", "gu": "છ! ચાલો છ ચોકલેટ ગણીએ!", "hi": "छह! आइए छह कैंडी गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Candies on this card? Counting Candies is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા ચોકલેટ શોધી શકો છો? ચોકલેટ ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी कैंडी पा सकते हैं? कैंडी गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 6. It represents 6 items.", "gu": "આપણે આ સંખ્યાને 6 તરીકે લખીએ છીએ. તે 6 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 6 के रूप में लिखते हैं। यह 6 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  6
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '7', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "7", "gu": "7", "hi": "7"}'::jsonb, 
  '/assets/svgs/numbers/7.svg', 
  '{"en": "Seven! Let''s count 7 Flowers.", "gu": "સાત! ચાલો સાત ફૂલો ગણીએ!", "hi": "सात! आइए सात फूल गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Flowers on this card? Counting Flowers is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા ફૂલો શોધી શકો છો? ફૂલો ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी फूल पा सकते हैं? फूल गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 7. It represents 7 items.", "gu": "આપણે આ સંખ્યાને 7 તરીકે લખીએ છીએ. તે 7 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 7 के रूप में लिखते हैं। यह 7 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  7
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '8', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "8", "gu": "8", "hi": "8"}'::jsonb, 
  '/assets/svgs/numbers/8.svg', 
  '{"en": "Eight! Let''s count 8 Coins.", "gu": "આઠ! ચાલો આઠ સિક્કા ગણીએ!", "hi": "आठ! आइए आठ सिक्के गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Coins on this card? Counting Coins is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા સિક્કા શોધી શકો છો? સિક્કા ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी सिक्के पा सकते हैं? सिक्के गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 8. It represents 8 items.", "gu": "આપણે આ સંખ્યાને 8 તરીકે લખીએ છીએ. તે 8 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 8 के रूप में लिखते हैं। यह 8 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  8
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '9', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "9", "gu": "9", "hi": "9"}'::jsonb, 
  '/assets/svgs/numbers/9.svg', 
  '{"en": "Nine! Let''s count 9 Cherries.", "gu": "નવ! ચાલો નવ ચેરી ગણીએ!", "hi": "नौ! आइए नौ ચેરી गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Cherries on this card? Counting Cherries is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા ચેરી શોધી શકો છો? ચેરી ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी ચેરી पा सकते हैं? ચેરી गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 9. It represents 9 items.", "gu": "આપણે આ સંખ્યાને 9 તરીકે લખીએ છીએ. તે 9 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 9 के रूप में लिखते हैं। यह 9 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  9
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '10', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "10", "gu": "10", "hi": "10"}'::jsonb, 
  '/assets/svgs/numbers/10.svg', 
  '{"en": "Ten! Let''s count 10 Suns.", "gu": "દસ! ચાલો દસ સૂરજ ગણીએ!", "hi": "दस! आइए दस सूरज गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Suns on this card? Counting Suns is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા સૂરજ શોધી શકો છો? સૂરજ ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी सूरज पा सकते हैं? सूरज गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 10. It represents 10 items.", "gu": "આપણે આ સંખ્યાને 10 તરીકે લખીએ છીએ. તે 10 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 10 के रूप में लिखते हैं। यह 10 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  10
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '11', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "11", "gu": "11", "hi": "11"}'::jsonb, 
  '/assets/svgs/numbers/11.svg', 
  '{"en": "Eleven! Let''s count 11 Apples.", "gu": "અગિયાર! ચાલો અગિયાર સફરજન ગણીએ!", "hi": "ग्यारह! आइए ग्यारह सेब गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Apples on this card? Counting Apples is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા સફરજન શોધી શકો છો? સફરજન ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी सेब पा सकते हैं? सेब गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 11. It represents 11 items.", "gu": "આપણે આ સંખ્યાને 11 તરીકે લખીએ છીએ. તે 11 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 11 के रूप में लिखते हैं। यह 11 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  11
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '12', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "12", "gu": "12", "hi": "12"}'::jsonb, 
  '/assets/svgs/numbers/12.svg', 
  '{"en": "Twelve! Let''s count 12 Stars.", "gu": "બાર! ચાલો બાર તારા ગણીએ!", "hi": "बारह! आइए बारह तारे गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Stars on this card? Counting Stars is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા તારા શોધી શકો છો? તારા ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी तारे पा सकते हैं? तारे गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 12. It represents 12 items.", "gu": "આપણે આ સંખ્યાને 12 તરીકે લખીએ છીએ. તે 12 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 12 के रूप में लिखते हैं। यह 12 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  12
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '13', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "13", "gu": "13", "hi": "13"}'::jsonb, 
  '/assets/svgs/numbers/13.svg', 
  '{"en": "Thirteen! Let''s count 13 Balloons.", "gu": "તેર! ચાલો તેર ફુગ્ગાઓ ગણીએ!", "hi": "तेरह! आइए तेरह गुब्बारे गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Balloons on this card? Counting Balloons is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા ફુગ્ગાઓ શોધી શકો છો? ફુગ્ગાઓ ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी गुब्बारे पा सकते हैं? गुब्बारे गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 13. It represents 13 items.", "gu": "આપણે આ સંખ્યાને 13 તરીકે લખીએ છીએ. તે 13 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 13 के रूप में लिखते हैं। यह 13 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  13
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '14', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "14", "gu": "14", "hi": "14"}'::jsonb, 
  '/assets/svgs/numbers/14.svg', 
  '{"en": "Fourteen! Let''s count 14 Bubbles.", "gu": "ચૌદ! ચાલો ચૌદ પરપોટા ગણીએ!", "hi": "चौदह! आइए चौदह बुलबुले गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Bubbles on this card? Counting Bubbles is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા પરપોટા શોધી શકો છો? પરપોટા ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी बुलबुले पा सकते हैं? बुलबुले गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 14. It represents 14 items.", "gu": "આપણે આ સંખ્યાને 14 તરીકે લખીએ છીએ. તે 14 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 14 के रूप में लिखते हैं। यह 14 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  14
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '15', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "15", "gu": "15", "hi": "15"}'::jsonb, 
  '/assets/svgs/numbers/15.svg', 
  '{"en": "Fifteen! Let''s count 15 Hearts.", "gu": "પંદર! ચાલો પંદર દિલ ગણીએ!", "hi": "पंद्रह! आइए पंद्रह दिल गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Hearts on this card? Counting Hearts is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા દિલ શોધી શકો છો? દિલ ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी दिल पा सकते हैं? दिल गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 15. It represents 15 items.", "gu": "આપણે આ સંખ્યાને 15 તરીકે લખીએ છીએ. તે 15 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 15 के रूप में लिखते हैं। यह 15 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  15
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '16', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "16", "gu": "16", "hi": "16"}'::jsonb, 
  '/assets/svgs/numbers/16.svg', 
  '{"en": "Sixteen! Let''s count 16 Candies.", "gu": "સોળ! ચાલો સોળ ચોકલેટ ગણીએ!", "hi": "सोलह! आइए सोलह कैंडी गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Candies on this card? Counting Candies is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા ચોકલેટ શોધી શકો છો? ચોકલેટ ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी कैंडी पा सकते हैं? कैंडी गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 16. It represents 16 items.", "gu": "આપણે આ સંખ્યાને 16 તરીકે લખીએ છીએ. તે 16 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 16 के रूप में लिखते हैं। यह 16 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  16
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '17', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "17", "gu": "17", "hi": "17"}'::jsonb, 
  '/assets/svgs/numbers/17.svg', 
  '{"en": "Seventeen! Let''s count 17 Flowers.", "gu": "સત્તર! ચાલો સત્તર ફૂલો ગણીએ!", "hi": "सत्रह! आइए सत्रह फूल गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Flowers on this card? Counting Flowers is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા ફૂલો શોધી શકો છો? ફૂલો ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी फूल पा सकते हैं? फूल गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 17. It represents 17 items.", "gu": "આપણે આ સંખ્યાને 17 તરીકે લખીએ છીએ. તે 17 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 17 के रूप में लिखते हैं। यह 17 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  17
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '18', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "18", "gu": "18", "hi": "18"}'::jsonb, 
  '/assets/svgs/numbers/18.svg', 
  '{"en": "Eighteen! Let''s count 18 Coins.", "gu": "અઢાર! ચાલો અઢાર સિક્કા ગણીએ!", "hi": "अठारह! आइए अठारह सिक्के गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Coins on this card? Counting Coins is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા સિક્કા શોધી શકો છો? સિક્કા ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी सिक्के पा सकते हैं? सिक्के गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 18. It represents 18 items.", "gu": "આપણે આ સંખ્યાને 18 તરીકે લખીએ છીએ. તે 18 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 18 के रूप में लिखते हैं। यह 18 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  18
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '19', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "19", "gu": "19", "hi": "19"}'::jsonb, 
  '/assets/svgs/numbers/19.svg', 
  '{"en": "Nineteen! Let''s count 19 Cherries.", "gu": "ઓગણીસ! ચાલો ઓગણીસ ચેરી ગણીએ!", "hi": "उन्नीस! आइए उन्नीस ચેરી गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Cherries on this card? Counting Cherries is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા ચેરી શોધી શકો છો? ચેરી ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी ચેરી पा सकते हैं? ચેરી गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 19. It represents 19 items.", "gu": "આપણે આ સંખ્યાને 19 તરીકે લખીએ છીએ. તે 19 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 19 के रूप में लिखते हैं। यह 19 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  19
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '20', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "20", "gu": "20", "hi": "20"}'::jsonb, 
  '/assets/svgs/numbers/20.svg', 
  '{"en": "Twenty! Let''s count 20 Suns.", "gu": "વીસ! ચાલો વીસ સૂરજ ગણીએ!", "hi": "बीस! आइए बीस सूरज गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Suns on this card? Counting Suns is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા સૂરજ શોધી શકો છો? સૂરજ ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी सूरज पा सकते हैं? सूरज गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 20. It represents 20 items.", "gu": "આપણે આ સંખ્યાને 20 તરીકે લખીએ છીએ. તે 20 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 20 के रूप में लिखते हैं। यह 20 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  20
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '21', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "21", "gu": "21", "hi": "21"}'::jsonb, 
  '/assets/svgs/numbers/21.svg', 
  '{"en": "Twenty One! Let''s count 21 Apples.", "gu": "એકવીસ! ચાલો એકવીસ સફરજન ગણીએ!", "hi": "इक्कीस! आइए इक्कीस सेब गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Apples on this card? Counting Apples is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા સફરજન શોધી શકો છો? સફરજન ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी सेब पा सकते हैं? सेब गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 21. It represents 21 items.", "gu": "આપણે આ સંખ્યાને 21 તરીકે લખીએ છીએ. તે 21 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 21 के रूप में लिखते हैं। यह 21 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  21
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '22', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "22", "gu": "22", "hi": "22"}'::jsonb, 
  '/assets/svgs/numbers/22.svg', 
  '{"en": "Twenty Two! Let''s count 22 Stars.", "gu": "બાવીસ! ચાલો બાવીસ તારા ગણીએ!", "hi": "बाईस! आइए बाईस तारे गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Stars on this card? Counting Stars is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા તારા શોધી શકો છો? તારા ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी तारे पा सकते हैं? तारे गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 22. It represents 22 items.", "gu": "આપણે આ સંખ્યાને 22 તરીકે લખીએ છીએ. તે 22 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 22 के रूप में लिखते हैं। यह 22 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  22
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '23', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "23", "gu": "23", "hi": "23"}'::jsonb, 
  '/assets/svgs/numbers/23.svg', 
  '{"en": "Twenty Three! Let''s count 23 Balloons.", "gu": "તેવીસ! ચાલો તેવીસ ફુગ્ગાઓ ગણીએ!", "hi": "तेईस! आइए तेईस गुब्बारे गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Balloons on this card? Counting Balloons is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા ફુગ્ગાઓ શોધી શકો છો? ફુગ્ગાઓ ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी गुब्बारे पा सकते हैं? गुब्बारे गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 23. It represents 23 items.", "gu": "આપણે આ સંખ્યાને 23 તરીકે લખીએ છીએ. તે 23 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 23 के रूप में लिखते हैं। यह 23 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  23
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '24', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "24", "gu": "24", "hi": "24"}'::jsonb, 
  '/assets/svgs/numbers/24.svg', 
  '{"en": "Twenty Four! Let''s count 24 Bubbles.", "gu": "ચોવીસ! ચાલો ચોવીસ પરપોટા ગણીએ!", "hi": "चौबीस! आइए चौबीस बुलबुले गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Bubbles on this card? Counting Bubbles is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા પરપોટા શોધી શકો છો? પરપોટા ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी बुलबुले पा सकते हैं? बुलबुले गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 24. It represents 24 items.", "gu": "આપણે આ સંખ્યાને 24 તરીકે લખીએ છીએ. તે 24 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 24 के रूप में लिखते हैं। यह 24 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  24
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '25', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "25", "gu": "25", "hi": "25"}'::jsonb, 
  '/assets/svgs/numbers/25.svg', 
  '{"en": "Twenty Five! Let''s count 25 Hearts.", "gu": "પચ્ચીસ! ચાલો પચ્ચીસ દિલ ગણીએ!", "hi": "पच्चीस! आइए पच्चीस दिल गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Hearts on this card? Counting Hearts is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા દિલ શોધી શકો છો? દિલ ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी दिल पा सकते हैं? दिल गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 25. It represents 25 items.", "gu": "આપણે આ સંખ્યાને 25 તરીકે લખીએ છીએ. તે 25 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 25 के रूप में लिखते हैं। यह 25 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  25
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '26', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "26", "gu": "26", "hi": "26"}'::jsonb, 
  '/assets/svgs/numbers/26.svg', 
  '{"en": "Twenty Six! Let''s count 26 Candies.", "gu": "છવ્વીસ! ચાલો છવ્વીસ ચોકલેટ ગણીએ!", "hi": "छब्बीस! आइए छब्बीस कैंडी गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Candies on this card? Counting Candies is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા ચોકલેટ શોધી શકો છો? ચોકલેટ ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी कैंडी पा सकते हैं? कैंडी गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 26. It represents 26 items.", "gu": "આપણે આ સંખ્યાને 26 તરીકે લખીએ છીએ. તે 26 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 26 के रूप में लिखते हैं। यह 26 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  26
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '27', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "27", "gu": "27", "hi": "27"}'::jsonb, 
  '/assets/svgs/numbers/27.svg', 
  '{"en": "Twenty Seven! Let''s count 27 Flowers.", "gu": "સત્તાવીસ! ચાલો સત્તાવીસ ફૂલો ગણીએ!", "hi": "सत्ताईस! आइए सत्ताईस फूल गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Flowers on this card? Counting Flowers is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા ફૂલો શોધી શકો છો? ફૂલો ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी फूल पा सकते हैं? फूल गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 27. It represents 27 items.", "gu": "આપણે આ સંખ્યાને 27 તરીકે લખીએ છીએ. તે 27 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 27 के रूप में लिखते हैं। यह 27 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  27
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '28', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "28", "gu": "28", "hi": "28"}'::jsonb, 
  '/assets/svgs/numbers/28.svg', 
  '{"en": "Twenty Eight! Let''s count 28 Coins.", "gu": "અઠ્ઠાવીસ! ચાલો અઠ્ઠાવીસ સિક્કા ગણીએ!", "hi": "अट्ठाईस! आइए अट्ठाईस सिक्के गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Coins on this card? Counting Coins is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા સિક્કા શોધી શકો છો? સિક્કા ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी सिक्के पा सकते हैं? सिक्के गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 28. It represents 28 items.", "gu": "આપણે આ સંખ્યાને 28 તરીકે લખીએ છીએ. તે 28 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 28 के रूप में लिखते हैं। यह 28 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  28
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '29', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "29", "gu": "29", "hi": "29"}'::jsonb, 
  '/assets/svgs/numbers/29.svg', 
  '{"en": "Twenty Nine! Let''s count 29 Cherries.", "gu": "ઓગણત્રીસ! ચાલો ઓગણત્રીસ ચેરી ગણીએ!", "hi": "उनतीस! आइए उनतीस ચેરી गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Cherries on this card? Counting Cherries is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા ચેરી શોધી શકો છો? ચેરી ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी ચેરી पा सकते हैं? ચેરી गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 29. It represents 29 items.", "gu": "આપણે આ સંખ્યાને 29 તરીકે લખીએ છીએ. તે 29 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 29 के रूप में लिखते हैं। यह 29 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  29
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '30', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "30", "gu": "30", "hi": "30"}'::jsonb, 
  '/assets/svgs/numbers/30.svg', 
  '{"en": "Thirty! Let''s count 30 Suns.", "gu": "ત્રીસ! ચાલો ત્રીસ સૂરજ ગણીએ!", "hi": "तीस! आइए तीस सूरज गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Suns on this card? Counting Suns is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા સૂરજ શોધી શકો છો? સૂરજ ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी सूरज पा सकते हैं? सूरज गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 30. It represents 30 items.", "gu": "આપણે આ સંખ્યાને 30 તરીકે લખીએ છીએ. તે 30 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 30 के रूप में लिखते हैं। यह 30 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  30
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '31', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "31", "gu": "31", "hi": "31"}'::jsonb, 
  '/assets/svgs/numbers/31.svg', 
  '{"en": "Thirty One! Let''s count 31 Apples.", "gu": "એકત્રીસ! ચાલો એકત્રીસ સફરજન ગણીએ!", "hi": "इकतीस! आइए इकतीस सेब गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Apples on this card? Counting Apples is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા સફરજન શોધી શકો છો? સફરજન ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी सेब पा सकते हैं? सेब गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 31. It represents 31 items.", "gu": "આપણે આ સંખ્યાને 31 તરીકે લખીએ છીએ. તે 31 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 31 के रूप में लिखते हैं। यह 31 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  31
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '32', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "32", "gu": "32", "hi": "32"}'::jsonb, 
  '/assets/svgs/numbers/32.svg', 
  '{"en": "Thirty Two! Let''s count 32 Stars.", "gu": "બત્રીસ! ચાલો બત્રીસ તારા ગણીએ!", "hi": "बत्तीस! आइए बत्तीस तारे गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Stars on this card? Counting Stars is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા તારા શોધી શકો છો? તારા ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी तारे पा सकते हैं? तारे गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 32. It represents 32 items.", "gu": "આપણે આ સંખ્યાને 32 તરીકે લખીએ છીએ. તે 32 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 32 के रूप में लिखते हैं। यह 32 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  32
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '33', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "33", "gu": "33", "hi": "33"}'::jsonb, 
  '/assets/svgs/numbers/33.svg', 
  '{"en": "Thirty Three! Let''s count 33 Balloons.", "gu": "તેત્રીસ! ચાલો તેત્રીસ ફુગ્ગાઓ ગણીએ!", "hi": "तैंतीस! आइए तैंतीस गुब्बारे गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Balloons on this card? Counting Balloons is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા ફુગ્ગાઓ શોધી શકો છો? ફુગ્ગાઓ ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी गुब्बारे पा सकते हैं? गुब्बारे गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 33. It represents 33 items.", "gu": "આપણે આ સંખ્યાને 33 તરીકે લખીએ છીએ. તે 33 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 33 के रूप में लिखते हैं। यह 33 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  33
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '34', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "34", "gu": "34", "hi": "34"}'::jsonb, 
  '/assets/svgs/numbers/34.svg', 
  '{"en": "Thirty Four! Let''s count 34 Bubbles.", "gu": "ચોત્રીસ! ચાલો ચોત્રીસ પરપોટા ગણીએ!", "hi": "चौंतीस! आइए चौंतीस बुलबुले गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Bubbles on this card? Counting Bubbles is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા પરપોટા શોધી શકો છો? પરપોટા ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी बुलबुले पा सकते हैं? बुलबुले गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 34. It represents 34 items.", "gu": "આપણે આ સંખ્યાને 34 તરીકે લખીએ છીએ. તે 34 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 34 के रूप में लिखते हैं। यह 34 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  34
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '35', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "35", "gu": "35", "hi": "35"}'::jsonb, 
  '/assets/svgs/numbers/35.svg', 
  '{"en": "Thirty Five! Let''s count 35 Hearts.", "gu": "પાંત્રીસ! ચાલો પાંત્રીસ દિલ ગણીએ!", "hi": "पैंतीस! आइए पैंतीस दिल गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Hearts on this card? Counting Hearts is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા દિલ શોધી શકો છો? દિલ ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी दिल पा सकते हैं? दिल गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 35. It represents 35 items.", "gu": "આપણે આ સંખ્યાને 35 તરીકે લખીએ છીએ. તે 35 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 35 के रूप में लिखते हैं। यह 35 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  35
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '36', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "36", "gu": "36", "hi": "36"}'::jsonb, 
  '/assets/svgs/numbers/36.svg', 
  '{"en": "Thirty Six! Let''s count 36 Candies.", "gu": "છત્રીસ! ચાલો છત્રીસ ચોકલેટ ગણીએ!", "hi": "छत्तीस! आइए छत्तीस कैंडी गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Candies on this card? Counting Candies is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા ચોકલેટ શોધી શકો છો? ચોકલેટ ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी कैंडी पा सकते हैं? कैंडी गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 36. It represents 36 items.", "gu": "આપણે આ સંખ્યાને 36 તરીકે લખીએ છીએ. તે 36 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 36 के रूप में लिखते हैं। यह 36 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  36
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '37', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "37", "gu": "37", "hi": "37"}'::jsonb, 
  '/assets/svgs/numbers/37.svg', 
  '{"en": "Thirty Seven! Let''s count 37 Flowers.", "gu": "સડત્રીસ! ચાલો સડત્રીસ ફૂલો ગણીએ!", "hi": "सैंतीस! आइए सैंतीस फूल गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Flowers on this card? Counting Flowers is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા ફૂલો શોધી શકો છો? ફૂલો ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी फूल पा सकते हैं? फूल गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 37. It represents 37 items.", "gu": "આપણે આ સંખ્યાને 37 તરીકે લખીએ છીએ. તે 37 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 37 के रूप में लिखते हैं। यह 37 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  37
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '38', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "38", "gu": "38", "hi": "38"}'::jsonb, 
  '/assets/svgs/numbers/38.svg', 
  '{"en": "Thirty Eight! Let''s count 38 Coins.", "gu": "અડત્રીસ! ચાલો અડત્રીસ સિક્કા ગણીએ!", "hi": "अड़तीस! आइए अड़तीस सिक्के गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Coins on this card? Counting Coins is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા સિક્કા શોધી શકો છો? સિક્કા ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी सिक्के पा सकते हैं? सिक्के गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 38. It represents 38 items.", "gu": "આપણે આ સંખ્યાને 38 તરીકે લખીએ છીએ. તે 38 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 38 के रूप में लिखते हैं। यह 38 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  38
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '39', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "39", "gu": "39", "hi": "39"}'::jsonb, 
  '/assets/svgs/numbers/39.svg', 
  '{"en": "Thirty Nine! Let''s count 39 Cherries.", "gu": "ઓગણચાલીસ! ચાલો ઓગણચાલીસ ચેરી ગણીએ!", "hi": "उनतालीस! आइए उनतालीस ચેરી गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Cherries on this card? Counting Cherries is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા ચેરી શોધી શકો છો? ચેરી ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी ચેરી पा सकते हैं? ચેરી गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 39. It represents 39 items.", "gu": "આપણે આ સંખ્યાને 39 તરીકે લખીએ છીએ. તે 39 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 39 के रूप में लिखते हैं। यह 39 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  39
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '40', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "40", "gu": "40", "hi": "40"}'::jsonb, 
  '/assets/svgs/numbers/40.svg', 
  '{"en": "Forty! Let''s count 40 Suns.", "gu": "ચાલીસ! ચાલો ચાલીસ સૂરજ ગણીએ!", "hi": "चालीस! आइए चालीस सूरज गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Suns on this card? Counting Suns is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા સૂરજ શોધી શકો છો? સૂરજ ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी सूरज पा सकते हैं? सूरज गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 40. It represents 40 items.", "gu": "આપણે આ સંખ્યાને 40 તરીકે લખીએ છીએ. તે 40 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 40 के रूप में लिखते हैं। यह 40 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  40
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '41', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "41", "gu": "41", "hi": "41"}'::jsonb, 
  '/assets/svgs/numbers/41.svg', 
  '{"en": "Forty One! Let''s count 41 Apples.", "gu": "એકતાલીસ! ચાલો એકતાલીસ સફરજન ગણીએ!", "hi": "इकतालीस! आइए इकतालीस सेब गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Apples on this card? Counting Apples is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા સફરજન શોધી શકો છો? સફરજન ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी सेब पा सकते हैं? सेब गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 41. It represents 41 items.", "gu": "આપણે આ સંખ્યાને 41 તરીકે લખીએ છીએ. તે 41 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 41 के रूप में लिखते हैं। यह 41 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  41
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '42', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "42", "gu": "42", "hi": "42"}'::jsonb, 
  '/assets/svgs/numbers/42.svg', 
  '{"en": "Forty Two! Let''s count 42 Stars.", "gu": "બેતાલીસ! ચાલો બેતાલીસ તારા ગણીએ!", "hi": "बयालीस! आइए बयालीस तारे गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Stars on this card? Counting Stars is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા તારા શોધી શકો છો? તારા ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी तारे पा सकते हैं? तारे गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 42. It represents 42 items.", "gu": "આપણે આ સંખ્યાને 42 તરીકે લખીએ છીએ. તે 42 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 42 के रूप में लिखते हैं। यह 42 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  42
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '43', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "43", "gu": "43", "hi": "43"}'::jsonb, 
  '/assets/svgs/numbers/43.svg', 
  '{"en": "Forty Three! Let''s count 43 Balloons.", "gu": "ત્રેતાલીસ! ચાલો ત્રેતાલીસ ફુગ્ગાઓ ગણીએ!", "hi": "तैंतालीस! आइए तैंतालीस गुब्बारे गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Balloons on this card? Counting Balloons is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા ફુગ્ગાઓ શોધી શકો છો? ફુગ્ગાઓ ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी गुब्बारे पा सकते हैं? गुब्बारे गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 43. It represents 43 items.", "gu": "આપણે આ સંખ્યાને 43 તરીકે લખીએ છીએ. તે 43 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 43 के रूप में लिखते हैं। यह 43 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  43
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '44', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "44", "gu": "44", "hi": "44"}'::jsonb, 
  '/assets/svgs/numbers/44.svg', 
  '{"en": "Forty Four! Let''s count 44 Bubbles.", "gu": "ચુંમાલીસ! ચાલો ચુંમાલીસ પરપોટા ગણીએ!", "hi": "चौवालीस! आइए चौवालीस बुलबुले गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Bubbles on this card? Counting Bubbles is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા પરપોટા શોધી શકો છો? પરપોટા ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी बुलबुले पा सकते हैं? बुलबुले गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 44. It represents 44 items.", "gu": "આપણે આ સંખ્યાને 44 તરીકે લખીએ છીએ. તે 44 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 44 के रूप में लिखते हैं। यह 44 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  44
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '45', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "45", "gu": "45", "hi": "45"}'::jsonb, 
  '/assets/svgs/numbers/45.svg', 
  '{"en": "Forty Five! Let''s count 45 Hearts.", "gu": "પિસ્તાલીસ! ચાલો પિસ્તાલીસ દિલ ગણીએ!", "hi": "पैंतालीस! आइए पैंतालीस दिल गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Hearts on this card? Counting Hearts is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા દિલ શોધી શકો છો? દિલ ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी दिल पा सकते हैं? दिल गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 45. It represents 45 items.", "gu": "આપણે આ સંખ્યાને 45 તરીકે લખીએ છીએ. તે 45 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 45 के रूप में लिखते हैं। यह 45 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  45
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '46', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "46", "gu": "46", "hi": "46"}'::jsonb, 
  '/assets/svgs/numbers/46.svg', 
  '{"en": "Forty Six! Let''s count 46 Candies.", "gu": "છેતાલીસ! ચાલો છેતાલીસ ચોકલેટ ગણીએ!", "hi": "छियालीस! आइए छियालीस कैंडी गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Candies on this card? Counting Candies is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા ચોકલેટ શોધી શકો છો? ચોકલેટ ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी कैंडी पा सकते हैं? कैंडी गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 46. It represents 46 items.", "gu": "આપણે આ સંખ્યાને 46 તરીકે લખીએ છીએ. તે 46 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 46 के रूप में लिखते हैं। यह 46 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  46
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '47', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "47", "gu": "47", "hi": "47"}'::jsonb, 
  '/assets/svgs/numbers/47.svg', 
  '{"en": "Forty Seven! Let''s count 47 Flowers.", "gu": "સુડતાલીસ! ચાલો સુડતાલીસ ફૂલો ગણીએ!", "hi": "सैंतालीस! आइए सैंतालीस फूल गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Flowers on this card? Counting Flowers is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા ફૂલો શોધી શકો છો? ફૂલો ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी फूल पा सकते हैं? फूल गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 47. It represents 47 items.", "gu": "આપણે આ સંખ્યાને 47 તરીકે લખીએ છીએ. તે 47 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 47 के रूप में लिखते हैं। यह 47 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  47
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '48', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "48", "gu": "48", "hi": "48"}'::jsonb, 
  '/assets/svgs/numbers/48.svg', 
  '{"en": "Forty Eight! Let''s count 48 Coins.", "gu": "અડતાલીસ! ચાલો અડતાલીસ સિક્કા ગણીએ!", "hi": "अड़तालीस! आइए अड़तालीस सिक्के गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Coins on this card? Counting Coins is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા સિક્કા શોધી શકો છો? સિક્કા ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी सिक्के पा सकते हैं? सिक्के गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 48. It represents 48 items.", "gu": "આપણે આ સંખ્યાને 48 તરીકે લખીએ છીએ. તે 48 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 48 के रूप में लिखते हैं। यह 48 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  48
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '49', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "49", "gu": "49", "hi": "49"}'::jsonb, 
  '/assets/svgs/numbers/49.svg', 
  '{"en": "Forty Nine! Let''s count 49 Cherries.", "gu": "ઓગણપચાસ! ચાલો ઓગણપચાસ ચેરી ગણીએ!", "hi": "उनचास! आइए उनचास ચેરી गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Cherries on this card? Counting Cherries is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા ચેરી શોધી શકો છો? ચેરી ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी ચેરી पा सकते हैं? ચેરી गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 49. It represents 49 items.", "gu": "આપણે આ સંખ્યાને 49 તરીકે લખીએ છીએ. તે 49 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 49 के रूप में लिखते हैं। यह 49 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  49
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '50', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "50", "gu": "50", "hi": "50"}'::jsonb, 
  '/assets/svgs/numbers/50.svg', 
  '{"en": "Fifty! Let''s count 50 Suns.", "gu": "પચાસ! ચાલો પચાસ સૂરજ ગણીએ!", "hi": "पचास! आइए पचास सूरज गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Suns on this card? Counting Suns is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા સૂરજ શોધી શકો છો? સૂરજ ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी सूरज पा सकते हैं? सूरज गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 50. It represents 50 items.", "gu": "આપણે આ સંખ્યાને 50 તરીકે લખીએ છીએ. તે 50 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 50 के रूप में लिखते हैं। यह 50 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  50
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '51', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "51", "gu": "51", "hi": "51"}'::jsonb, 
  '/assets/svgs/numbers/51.svg', 
  '{"en": "Fifty One! Let''s count 51 Apples.", "gu": "એકાવન! ચાલો એકાવન સફરજન ગણીએ!", "hi": "इक्यावन! आइए इक्यावन सेब गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Apples on this card? Counting Apples is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા સફરજન શોધી શકો છો? સફરજન ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी सेब पा सकते हैं? सेब गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 51. It represents 51 items.", "gu": "આપણે આ સંખ્યાને 51 તરીકે લખીએ છીએ. તે 51 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 51 के रूप में लिखते हैं। यह 51 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  51
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '52', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "52", "gu": "52", "hi": "52"}'::jsonb, 
  '/assets/svgs/numbers/52.svg', 
  '{"en": "Fifty Two! Let''s count 52 Stars.", "gu": "બાવન! ચાલો બાવન તારા ગણીએ!", "hi": "बावन! आइए बावन तारे गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Stars on this card? Counting Stars is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા તારા શોધી શકો છો? તારા ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी तारे पा सकते हैं? तारे गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 52. It represents 52 items.", "gu": "આપણે આ સંખ્યાને 52 તરીકે લખીએ છીએ. તે 52 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 52 के रूप में लिखते हैं। यह 52 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  52
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '53', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "53", "gu": "53", "hi": "53"}'::jsonb, 
  '/assets/svgs/numbers/53.svg', 
  '{"en": "Fifty Three! Let''s count 53 Balloons.", "gu": "ત્રેપન! ચાલો ત્રેપન ફુગ્ગાઓ ગણીએ!", "hi": "तिरपन! आइए तिरपन गुब्बारे गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Balloons on this card? Counting Balloons is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા ફુગ્ગાઓ શોધી શકો છો? ફુગ્ગાઓ ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी गुब्बारे पा सकते हैं? गुब्बारे गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 53. It represents 53 items.", "gu": "આપણે આ સંખ્યાને 53 તરીકે લખીએ છીએ. તે 53 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 53 के रूप में लिखते हैं। यह 53 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  53
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '54', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "54", "gu": "54", "hi": "54"}'::jsonb, 
  '/assets/svgs/numbers/54.svg', 
  '{"en": "Fifty Four! Let''s count 54 Bubbles.", "gu": "ચોપન! ચાલો ચોપન પરપોટા ગણીએ!", "hi": "चौवन! आइए चौवन बुलबुले गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Bubbles on this card? Counting Bubbles is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા પરપોટા શોધી શકો છો? પરપોટા ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी बुलबुले पा सकते हैं? बुलबुले गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 54. It represents 54 items.", "gu": "આપણે આ સંખ્યાને 54 તરીકે લખીએ છીએ. તે 54 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 54 के रूप में लिखते हैं। यह 54 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  54
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '55', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "55", "gu": "55", "hi": "55"}'::jsonb, 
  '/assets/svgs/numbers/55.svg', 
  '{"en": "Fifty Five! Let''s count 55 Hearts.", "gu": "પંચાવન! ચાલો પંચાવન દિલ ગણીએ!", "hi": "पचपन! आइए पचपन दिल गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Hearts on this card? Counting Hearts is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા દિલ શોધી શકો છો? દિલ ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी दिल पा सकते हैं? दिल गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 55. It represents 55 items.", "gu": "આપણે આ સંખ્યાને 55 તરીકે લખીએ છીએ. તે 55 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 55 के रूप में लिखते हैं। यह 55 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  55
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '56', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "56", "gu": "56", "hi": "56"}'::jsonb, 
  '/assets/svgs/numbers/56.svg', 
  '{"en": "Fifty Six! Let''s count 56 Candies.", "gu": "છપ્પન! ચાલો છપ્પન ચોકલેટ ગણીએ!", "hi": "छप्पन! आइए छप्पन कैंडी गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Candies on this card? Counting Candies is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા ચોકલેટ શોધી શકો છો? ચોકલેટ ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी कैंडी पा सकते हैं? कैंडी गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 56. It represents 56 items.", "gu": "આપણે આ સંખ્યાને 56 તરીકે લખીએ છીએ. તે 56 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 56 के रूप में लिखते हैं। यह 56 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  56
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '57', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "57", "gu": "57", "hi": "57"}'::jsonb, 
  '/assets/svgs/numbers/57.svg', 
  '{"en": "Fifty Seven! Let''s count 57 Flowers.", "gu": "સત્તાવન! ચાલો સત્તાવન ફૂલો ગણીએ!", "hi": "सत्तावन! आइए सत्तावन फूल गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Flowers on this card? Counting Flowers is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા ફૂલો શોધી શકો છો? ફૂલો ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी फूल पा सकते हैं? फूल गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 57. It represents 57 items.", "gu": "આપણે આ સંખ્યાને 57 તરીકે લખીએ છીએ. તે 57 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 57 के रूप में लिखते हैं। यह 57 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  57
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '58', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "58", "gu": "58", "hi": "58"}'::jsonb, 
  '/assets/svgs/numbers/58.svg', 
  '{"en": "Fifty Eight! Let''s count 58 Coins.", "gu": "અઠ્ઠાવન! ચાલો અઠ્ઠાવન સિક્કા ગણીએ!", "hi": "अट्ठावन! आइए अट्ठावन सिक्के गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Coins on this card? Counting Coins is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા સિક્કા શોધી શકો છો? સિક્કા ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी सिक्के पा सकते हैं? सिक्के गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 58. It represents 58 items.", "gu": "આપણે આ સંખ્યાને 58 તરીકે લખીએ છીએ. તે 58 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 58 के रूप में लिखते हैं। यह 58 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  58
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '59', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "59", "gu": "59", "hi": "59"}'::jsonb, 
  '/assets/svgs/numbers/59.svg', 
  '{"en": "Fifty Nine! Let''s count 59 Cherries.", "gu": "ઓગણસાઠ! ચાલો ઓગણસાઠ ચેરી ગણીએ!", "hi": "उनसठ! आइए उनसठ ચેરી गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Cherries on this card? Counting Cherries is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા ચેરી શોધી શકો છો? ચેરી ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी ચેરી पा सकते हैं? ચેરી गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 59. It represents 59 items.", "gu": "આપણે આ સંખ્યાને 59 તરીકે લખીએ છીએ. તે 59 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 59 के रूप में लिखते हैं। यह 59 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  59
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '60', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "60", "gu": "60", "hi": "60"}'::jsonb, 
  '/assets/svgs/numbers/60.svg', 
  '{"en": "Sixty! Let''s count 60 Suns.", "gu": "સાંઇઠ! ચાલો સાંઇઠ સૂરજ ગણીએ!", "hi": "साठ! आइए साठ सूरज गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Suns on this card? Counting Suns is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા સૂરજ શોધી શકો છો? સૂરજ ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी सूरज पा सकते हैं? सूरज गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 60. It represents 60 items.", "gu": "આપણે આ સંખ્યાને 60 તરીકે લખીએ છીએ. તે 60 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 60 के रूप में लिखते हैं। यह 60 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  60
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '61', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "61", "gu": "61", "hi": "61"}'::jsonb, 
  '/assets/svgs/numbers/61.svg', 
  '{"en": "Sixty One! Let''s count 61 Apples.", "gu": "એકઠ! ચાલો એકઠ સફરજન ગણીએ!", "hi": "इकसठ! आइए इकसठ सेब गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Apples on this card? Counting Apples is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા સફરજન શોધી શકો છો? સફરજન ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी सेब पा सकते हैं? सेब गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 61. It represents 61 items.", "gu": "આપણે આ સંખ્યાને 61 તરીકે લખીએ છીએ. તે 61 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 61 के रूप में लिखते हैं। यह 61 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  61
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '62', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "62", "gu": "62", "hi": "62"}'::jsonb, 
  '/assets/svgs/numbers/62.svg', 
  '{"en": "Sixty Two! Let''s count 62 Stars.", "gu": "બેસઠ! ચાલો બેસઠ તારા ગણીએ!", "hi": "बासठ! आइए बासठ तारे गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Stars on this card? Counting Stars is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા તારા શોધી શકો છો? તારા ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी तारे पा सकते हैं? तारे गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 62. It represents 62 items.", "gu": "આપણે આ સંખ્યાને 62 તરીકે લખીએ છીએ. તે 62 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 62 के रूप में लिखते हैं। यह 62 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  62
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '63', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "63", "gu": "63", "hi": "63"}'::jsonb, 
  '/assets/svgs/numbers/63.svg', 
  '{"en": "Sixty Three! Let''s count 63 Balloons.", "gu": "ત્રેસઠ! ચાલો ત્રેસઠ ફુગ્ગાઓ ગણીએ!", "hi": "तिरसठ! आइए तिरसठ गुब्बारे गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Balloons on this card? Counting Balloons is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા ફુગ્ગાઓ શોધી શકો છો? ફુગ્ગાઓ ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी गुब्बारे पा सकते हैं? गुब्बारे गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 63. It represents 63 items.", "gu": "આપણે આ સંખ્યાને 63 તરીકે લખીએ છીએ. તે 63 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 63 के रूप में लिखते हैं। यह 63 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  63
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '64', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "64", "gu": "64", "hi": "64"}'::jsonb, 
  '/assets/svgs/numbers/64.svg', 
  '{"en": "Sixty Four! Let''s count 64 Bubbles.", "gu": "ચોસઠ! ચાલો ચોસઠ પરપોટા ગણીએ!", "hi": "चौंसठ! आइए चौंसठ बुलबुले गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Bubbles on this card? Counting Bubbles is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા પરપોટા શોધી શકો છો? પરપોટા ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी बुलबुले पा सकते हैं? बुलबुले गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 64. It represents 64 items.", "gu": "આપણે આ સંખ્યાને 64 તરીકે લખીએ છીએ. તે 64 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 64 के रूप में लिखते हैं। यह 64 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  64
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '65', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "65", "gu": "65", "hi": "65"}'::jsonb, 
  '/assets/svgs/numbers/65.svg', 
  '{"en": "Sixty Five! Let''s count 65 Hearts.", "gu": "પાંસઠ! ચાલો પાંસઠ દિલ ગણીએ!", "hi": "पैंसठ! आइए पैंसठ दिल गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Hearts on this card? Counting Hearts is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા દિલ શોધી શકો છો? દિલ ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी दिल पा सकते हैं? दिल गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 65. It represents 65 items.", "gu": "આપણે આ સંખ્યાને 65 તરીકે લખીએ છીએ. તે 65 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 65 के रूप में लिखते हैं। यह 65 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  65
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '66', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "66", "gu": "66", "hi": "66"}'::jsonb, 
  '/assets/svgs/numbers/66.svg', 
  '{"en": "Sixty Six! Let''s count 66 Candies.", "gu": "છેાસઠ! ચાલો છેાસઠ ચોકલેટ ગણીએ!", "hi": "छियासठ! आइए छियासठ कैंडी गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Candies on this card? Counting Candies is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા ચોકલેટ શોધી શકો છો? ચોકલેટ ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी कैंडी पा सकते हैं? कैंडी गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 66. It represents 66 items.", "gu": "આપણે આ સંખ્યાને 66 તરીકે લખીએ છીએ. તે 66 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 66 के रूप में लिखते हैं। यह 66 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  66
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '67', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "67", "gu": "67", "hi": "67"}'::jsonb, 
  '/assets/svgs/numbers/67.svg', 
  '{"en": "Sixty Seven! Let''s count 67 Flowers.", "gu": "સડસઠ! ચાલો સડસઠ ફૂલો ગણીએ!", "hi": "सड़सठ! आइए सड़सठ फूल गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Flowers on this card? Counting Flowers is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા ફૂલો શોધી શકો છો? ફૂલો ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी फूल पा सकते हैं? फूल गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 67. It represents 67 items.", "gu": "આપણે આ સંખ્યાને 67 તરીકે લખીએ છીએ. તે 67 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 67 के रूप में लिखते हैं। यह 67 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  67
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '68', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "68", "gu": "68", "hi": "68"}'::jsonb, 
  '/assets/svgs/numbers/68.svg', 
  '{"en": "Sixty Eight! Let''s count 68 Coins.", "gu": "અડસઠ! ચાલો અડસઠ સિક્કા ગણીએ!", "hi": "अड़सठ! आइए अड़सठ सिक्के गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Coins on this card? Counting Coins is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા સિક્કા શોધી શકો છો? સિક્કા ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी सिक्के पा सकते हैं? सिक्के गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 68. It represents 68 items.", "gu": "આપણે આ સંખ્યાને 68 તરીકે લખીએ છીએ. તે 68 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 68 के रूप में लिखते हैं। यह 68 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  68
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '69', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "69", "gu": "69", "hi": "69"}'::jsonb, 
  '/assets/svgs/numbers/69.svg', 
  '{"en": "Sixty Nine! Let''s count 69 Cherries.", "gu": "ઓગણસિત્તેર! ચાલો ઓગણસિત્તેર ચેરી ગણીએ!", "hi": "उनहत्तर! आइए उनहत्तर ચેરી गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Cherries on this card? Counting Cherries is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા ચેરી શોધી શકો છો? ચેરી ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी ચેરી पा सकते हैं? ચેરી गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 69. It represents 69 items.", "gu": "આપણે આ સંખ્યાને 69 તરીકે લખીએ છીએ. તે 69 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 69 के रूप में लिखते हैं। यह 69 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  69
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '70', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "70", "gu": "70", "hi": "70"}'::jsonb, 
  '/assets/svgs/numbers/70.svg', 
  '{"en": "Seventy! Let''s count 70 Suns.", "gu": "સિત્તેર! ચાલો સિત્તેર સૂરજ ગણીએ!", "hi": "सत्तर! आइए सत्तर सूरज गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Suns on this card? Counting Suns is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા સૂરજ શોધી શકો છો? સૂરજ ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी सूरज पा सकते हैं? सूरज गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 70. It represents 70 items.", "gu": "આપણે આ સંખ્યાને 70 તરીકે લખીએ છીએ. તે 70 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 70 के रूप में लिखते हैं। यह 70 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  70
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '71', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "71", "gu": "71", "hi": "71"}'::jsonb, 
  '/assets/svgs/numbers/71.svg', 
  '{"en": "Seventy One! Let''s count 71 Apples.", "gu": "એકતેર! ચાલો એકતેર સફરજન ગણીએ!", "hi": "इकहत्तर! आइए इकहत्तर सेब गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Apples on this card? Counting Apples is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા સફરજન શોધી શકો છો? સફરજન ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी सेब पा सकते हैं? सेब गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 71. It represents 71 items.", "gu": "આપણે આ સંખ્યાને 71 તરીકે લખીએ છીએ. તે 71 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 71 के रूप में लिखते हैं। यह 71 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  71
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '72', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "72", "gu": "72", "hi": "72"}'::jsonb, 
  '/assets/svgs/numbers/72.svg', 
  '{"en": "Seventy Two! Let''s count 72 Stars.", "gu": "બોતેર! ચાલો બોતેર તારા ગણીએ!", "hi": "बहत्तर! आइए बहत्तर तारे गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Stars on this card? Counting Stars is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા તારા શોધી શકો છો? તારા ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी तारे पा सकते हैं? तारे गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 72. It represents 72 items.", "gu": "આપણે આ સંખ્યાને 72 તરીકે લખીએ છીએ. તે 72 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 72 के रूप में लिखते हैं। यह 72 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  72
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '73', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "73", "gu": "73", "hi": "73"}'::jsonb, 
  '/assets/svgs/numbers/73.svg', 
  '{"en": "Seventy Three! Let''s count 73 Balloons.", "gu": "તેતેર! ચાલો તેતેર ફુગ્ગાઓ ગણીએ!", "hi": "तिहत्तर! आइए तिहत्तर गुब्बारे गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Balloons on this card? Counting Balloons is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા ફુગ્ગાઓ શોધી શકો છો? ફુગ્ગાઓ ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी गुब्बारे पा सकते हैं? गुब्बारे गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 73. It represents 73 items.", "gu": "આપણે આ સંખ્યાને 73 તરીકે લખીએ છીએ. તે 73 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 73 के रूप में लिखते हैं। यह 73 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  73
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '74', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "74", "gu": "74", "hi": "74"}'::jsonb, 
  '/assets/svgs/numbers/74.svg', 
  '{"en": "Seventy Four! Let''s count 74 Bubbles.", "gu": "ચોતેર! ચાલો ચોતેર પરપોટા ગણીએ!", "hi": "चौहत्तर! आइए चौहत्तर बुलबुले गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Bubbles on this card? Counting Bubbles is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા પરપોટા શોધી શકો છો? પરપોટા ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी बुलबुले पा सकते हैं? बुलबुले गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 74. It represents 74 items.", "gu": "આપણે આ સંખ્યાને 74 તરીકે લખીએ છીએ. તે 74 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 74 के रूप में लिखते हैं। यह 74 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  74
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '75', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "75", "gu": "75", "hi": "75"}'::jsonb, 
  '/assets/svgs/numbers/75.svg', 
  '{"en": "Seventy Five! Let''s count 75 Hearts.", "gu": "પંચોતેર! ચાલો પંચોતેર દિલ ગણીએ!", "hi": "पचहत्तर! आइए पचहत्तर दिल गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Hearts on this card? Counting Hearts is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા દિલ શોધી શકો છો? દિલ ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी दिल पा सकते हैं? दिल गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 75. It represents 75 items.", "gu": "આપણે આ સંખ્યાને 75 તરીકે લખીએ છીએ. તે 75 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 75 के रूप में लिखते हैं। यह 75 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  75
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '76', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "76", "gu": "76", "hi": "76"}'::jsonb, 
  '/assets/svgs/numbers/76.svg', 
  '{"en": "Seventy Six! Let''s count 76 Candies.", "gu": "છોતેર! ચાલો છોતેર ચોકલેટ ગણીએ!", "hi": "छिहत्तर! आइए छिहत्तर कैंडी गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Candies on this card? Counting Candies is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા ચોકલેટ શોધી શકો છો? ચોકલેટ ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी कैंडी पा सकते हैं? कैंडी गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 76. It represents 76 items.", "gu": "આપણે આ સંખ્યાને 76 તરીકે લખીએ છીએ. તે 76 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 76 के रूप में लिखते हैं। यह 76 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  76
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '77', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "77", "gu": "77", "hi": "77"}'::jsonb, 
  '/assets/svgs/numbers/77.svg', 
  '{"en": "Seventy Seven! Let''s count 77 Flowers.", "gu": "ઈઠ્યોતેર! ચાલો ઈઠ્યોતેર ફૂલો ગણીએ!", "hi": "सतहत्तर! आइए सतहत्तर फूल गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Flowers on this card? Counting Flowers is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા ફૂલો શોધી શકો છો? ફૂલો ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी फूल पा सकते हैं? फूल गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 77. It represents 77 items.", "gu": "આપણે આ સંખ્યાને 77 તરીકે લખીએ છીએ. તે 77 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 77 के रूप में लिखते हैं। यह 77 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  77
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '78', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "78", "gu": "78", "hi": "78"}'::jsonb, 
  '/assets/svgs/numbers/78.svg', 
  '{"en": "Seventy Eight! Let''s count 78 Coins.", "gu": "ઈગ્નાણોતેર! ચાલો ઈગ્નાણોતેર સિક્કા ગણીએ!", "hi": "अठहत्तर! आइए अठहत्तर सिक्के गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Coins on this card? Counting Coins is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા સિક્કા શોધી શકો છો? સિક્કા ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी सिक्के पा सकते हैं? सिक्के गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 78. It represents 78 items.", "gu": "આપણે આ સંખ્યાને 78 તરીકે લખીએ છીએ. તે 78 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 78 के रूप में लिखते हैं। यह 78 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  78
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '79', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "79", "gu": "79", "hi": "79"}'::jsonb, 
  '/assets/svgs/numbers/79.svg', 
  '{"en": "Seventy Nine! Let''s count 79 Cherries.", "gu": "નેવું! ચાલો નેવું ચેરી ગણીએ!", "hi": "उन्यासी! आइए उन्यासी ચેરી गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Cherries on this card? Counting Cherries is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા ચેરી શોધી શકો છો? ચેરી ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी ચેરી पा सकते हैं? ચેરી गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 79. It represents 79 items.", "gu": "આપણે આ સંખ્યાને 79 તરીકે લખીએ છીએ. તે 79 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 79 के रूप में लिखते हैं। यह 79 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  79
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '80', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "80", "gu": "80", "hi": "80"}'::jsonb, 
  '/assets/svgs/numbers/80.svg', 
  '{"en": "Eighty! Let''s count 80 Suns.", "gu": "એંસી! ચાલો એંસી સૂરજ ગણીએ!", "hi": "अस्सी! आइए अस्सी सूरज गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Suns on this card? Counting Suns is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા સૂરજ શોધી શકો છો? સૂરજ ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी सूरज पा सकते हैं? सूरज गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 80. It represents 80 items.", "gu": "આપણે આ સંખ્યાને 80 તરીકે લખીએ છીએ. તે 80 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 80 के रूप में लिखते हैं। यह 80 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  80
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '81', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "81", "gu": "81", "hi": "81"}'::jsonb, 
  '/assets/svgs/numbers/81.svg', 
  '{"en": "Eighty One! Let''s count 81 Apples.", "gu": "એક્યાસી! ચાલો એક્યાસી સફરજન ગણીએ!", "hi": "इक्यासी! आइए इक्यासी सेब गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Apples on this card? Counting Apples is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા સફરજન શોધી શકો છો? સફરજન ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी सेब पा सकते हैं? सेब गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 81. It represents 81 items.", "gu": "આપણે આ સંખ્યાને 81 તરીકે લખીએ છીએ. તે 81 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 81 के रूप में लिखते हैं। यह 81 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  81
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '82', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "82", "gu": "82", "hi": "82"}'::jsonb, 
  '/assets/svgs/numbers/82.svg', 
  '{"en": "Eighty Two! Let''s count 82 Stars.", "gu": "બ્યાસી! ચાલો બ્યાસી તારા ગણીએ!", "hi": "बयासी! आइए बयासी तारे गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Stars on this card? Counting Stars is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા તારા શોધી શકો છો? તારા ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी तारे पा सकते हैं? तारे गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 82. It represents 82 items.", "gu": "આપણે આ સંખ્યાને 82 તરીકે લખીએ છીએ. તે 82 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 82 के रूप में लिखते हैं। यह 82 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  82
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '83', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "83", "gu": "83", "hi": "83"}'::jsonb, 
  '/assets/svgs/numbers/83.svg', 
  '{"en": "Eighty Three! Let''s count 83 Balloons.", "gu": "ત્યાસી! ચાલો ત્યાસી ફુગ્ગાઓ ગણીએ!", "hi": "तिरासी! आइए तिरासी गुब्बारे गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Balloons on this card? Counting Balloons is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા ફુગ્ગાઓ શોધી શકો છો? ફુગ્ગાઓ ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी गुब्बारे पा सकते हैं? गुब्बारे गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 83. It represents 83 items.", "gu": "આપણે આ સંખ્યાને 83 તરીકે લખીએ છીએ. તે 83 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 83 के रूप में लिखते हैं। यह 83 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  83
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '84', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "84", "gu": "84", "hi": "84"}'::jsonb, 
  '/assets/svgs/numbers/84.svg', 
  '{"en": "Eighty Four! Let''s count 84 Bubbles.", "gu": "ચોર્યાસી! ચાલો ચોર્યાસી પરપોટા ગણીએ!", "hi": "चौरासी! आइए चौरासी बुलबुले गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Bubbles on this card? Counting Bubbles is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા પરપોટા શોધી શકો છો? પરપોટા ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी बुलबुले पा सकते हैं? बुलबुले गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 84. It represents 84 items.", "gu": "આપણે આ સંખ્યાને 84 તરીકે લખીએ છીએ. તે 84 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 84 के रूप में लिखते हैं। यह 84 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  84
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '85', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "85", "gu": "85", "hi": "85"}'::jsonb, 
  '/assets/svgs/numbers/85.svg', 
  '{"en": "Eighty Five! Let''s count 85 Hearts.", "gu": "પંચ્યાસી! ચાલો પંચ્યાસી દિલ ગણીએ!", "hi": "पचासी! आइए पचासी दिल गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Hearts on this card? Counting Hearts is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા દિલ શોધી શકો છો? દિલ ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी दिल पा सकते हैं? दिल गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 85. It represents 85 items.", "gu": "આપણે આ સંખ્યાને 85 તરીકે લખીએ છીએ. તે 85 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 85 के रूप में लिखते हैं। यह 85 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  85
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '86', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "86", "gu": "86", "hi": "86"}'::jsonb, 
  '/assets/svgs/numbers/86.svg', 
  '{"en": "Eighty Six! Let''s count 86 Candies.", "gu": "છ્યાસી! ચાલો છ્યાસી ચોકલેટ ગણીએ!", "hi": "छियासी! आइए छियासी कैंडी गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Candies on this card? Counting Candies is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા ચોકલેટ શોધી શકો છો? ચોકલેટ ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी कैंडी पा सकते हैं? कैंडी गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 86. It represents 86 items.", "gu": "આપણે આ સંખ્યાને 86 તરીકે લખીએ છીએ. તે 86 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 86 के रूप में लिखते हैं। यह 86 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  86
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '87', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "87", "gu": "87", "hi": "87"}'::jsonb, 
  '/assets/svgs/numbers/87.svg', 
  '{"en": "Eighty Seven! Let''s count 87 Flowers.", "gu": "સિત્યાસી! ચાલો સિત્યાસી ફૂલો ગણીએ!", "hi": "सत्तासी! आइए सत्तासी फूल गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Flowers on this card? Counting Flowers is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા ફૂલો શોધી શકો છો? ફૂલો ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी फूल पा सकते हैं? फूल गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 87. It represents 87 items.", "gu": "આપણે આ સંખ્યાને 87 તરીકે લખીએ છીએ. તે 87 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 87 के रूप में लिखते हैं। यह 87 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  87
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '88', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "88", "gu": "88", "hi": "88"}'::jsonb, 
  '/assets/svgs/numbers/88.svg', 
  '{"en": "Eighty Eight! Let''s count 88 Coins.", "gu": "અઠ્યાસી! ચાલો અઠ્યાસી સિક્કા ગણીએ!", "hi": "अट्ठासी! आइए अट्ठासी सिक्के गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Coins on this card? Counting Coins is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા સિક્કા શોધી શકો છો? સિક્કા ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी सिक्के पा सकते हैं? सिक्के गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 88. It represents 88 items.", "gu": "આપણે આ સંખ્યાને 88 તરીકે લખીએ છીએ. તે 88 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 88 के रूप में लिखते हैं। यह 88 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  88
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '89', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "89", "gu": "89", "hi": "89"}'::jsonb, 
  '/assets/svgs/numbers/89.svg', 
  '{"en": "Eighty Nine! Let''s count 89 Cherries.", "gu": "નેવ્યાસી! ચાલો નેવ્યાસી ચેરી ગણીએ!", "hi": "नवासी! आइए नवासी ચેરી गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Cherries on this card? Counting Cherries is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા ચેરી શોધી શકો છો? ચેરી ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी ચેરી पा सकते हैं? ચેરી गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 89. It represents 89 items.", "gu": "આપણે આ સંખ્યાને 89 તરીકે લખીએ છીએ. તે 89 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 89 के रूप में लिखते हैं। यह 89 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  89
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '90', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "90", "gu": "90", "hi": "90"}'::jsonb, 
  '/assets/svgs/numbers/90.svg', 
  '{"en": "Ninety! Let''s count 90 Suns.", "gu": "નેવું! ચાલો નેવું સૂરજ ગણીએ!", "hi": "नब्बे! आइए नब्बे सूरज गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Suns on this card? Counting Suns is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા સૂરજ શોધી શકો છો? સૂરજ ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी सूरज पा सकते हैं? सूरज गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 90. It represents 90 items.", "gu": "આપણે આ સંખ્યાને 90 તરીકે લખીએ છીએ. તે 90 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 90 के रूप में लिखते हैं। यह 90 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  90
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '91', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "91", "gu": "91", "hi": "91"}'::jsonb, 
  '/assets/svgs/numbers/91.svg', 
  '{"en": "Ninety One! Let''s count 91 Apples.", "gu": "એકરાણું! ચાલો એકરાણું સફરજન ગણીએ!", "hi": "इक्यानवे! आइए इक्यानवे सेब गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Apples on this card? Counting Apples is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા સફરજન શોધી શકો છો? સફરજન ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी सेब पा सकते हैं? सेब गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 91. It represents 91 items.", "gu": "આપણે આ સંખ્યાને 91 તરીકે લખીએ છીએ. તે 91 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 91 के रूप में लिखते हैं। यह 91 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  91
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '92', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "92", "gu": "92", "hi": "92"}'::jsonb, 
  '/assets/svgs/numbers/92.svg', 
  '{"en": "Ninety Two! Let''s count 92 Stars.", "gu": "બાણું! ચાલો બાણું તારા ગણીએ!", "hi": "बानवे! आइए बानवे तारे गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Stars on this card? Counting Stars is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા તારા શોધી શકો છો? તારા ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी तारे पा सकते हैं? तारे गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 92. It represents 92 items.", "gu": "આપણે આ સંખ્યાને 92 તરીકે લખીએ છીએ. તે 92 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 92 के रूप में लिखते हैं। यह 92 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  92
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '93', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "93", "gu": "93", "hi": "93"}'::jsonb, 
  '/assets/svgs/numbers/93.svg', 
  '{"en": "Ninety Three! Let''s count 93 Balloons.", "gu": "ત્રાણું! ચાલો ત્રાણું ફુગ્ગાઓ ગણીએ!", "hi": "तिरानवे! आइए तिरानवे गुब्बारे गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Balloons on this card? Counting Balloons is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા ફુગ્ગાઓ શોધી શકો છો? ફુગ્ગાઓ ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी गुब्बारे पा सकते हैं? गुब्बारे गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 93. It represents 93 items.", "gu": "આપણે આ સંખ્યાને 93 તરીકે લખીએ છીએ. તે 93 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 93 के रूप में लिखते हैं। यह 93 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  93
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '94', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "94", "gu": "94", "hi": "94"}'::jsonb, 
  '/assets/svgs/numbers/94.svg', 
  '{"en": "Ninety Four! Let''s count 94 Bubbles.", "gu": "ચોરાણું! ચાલો ચોરાણું પરપોટા ગણીએ!", "hi": "चौरानवे! आइए चौरानवे बुलबुले गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Bubbles on this card? Counting Bubbles is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા પરપોટા શોધી શકો છો? પરપોટા ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी बुलबुले पा सकते हैं? बुलबुले गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 94. It represents 94 items.", "gu": "આપણે આ સંખ્યાને 94 તરીકે લખીએ છીએ. તે 94 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 94 के रूप में लिखते हैं। यह 94 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  94
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '95', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "95", "gu": "95", "hi": "95"}'::jsonb, 
  '/assets/svgs/numbers/95.svg', 
  '{"en": "Ninety Five! Let''s count 95 Hearts.", "gu": "પંચાણું! ચાલો પંચાણું દિલ ગણીએ!", "hi": "पचानवे! आइए पचानवे दिल गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Hearts on this card? Counting Hearts is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા દિલ શોધી શકો છો? દિલ ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी दिल पा सकते हैं? दिल गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 95. It represents 95 items.", "gu": "આપણે આ સંખ્યાને 95 તરીકે લખીએ છીએ. તે 95 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 95 के रूप में लिखते हैं। यह 95 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  95
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '96', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "96", "gu": "96", "hi": "96"}'::jsonb, 
  '/assets/svgs/numbers/96.svg', 
  '{"en": "Ninety Six! Let''s count 96 Candies.", "gu": "છન્નું! ચાલો છન્નું ચોકલેટ ગણીએ!", "hi": "छियानवे! आइए छियानवे कैंडी गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Candies on this card? Counting Candies is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા ચોકલેટ શોધી શકો છો? ચોકલેટ ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी कैंडी पा सकते हैं? कैंडी गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 96. It represents 96 items.", "gu": "આપણે આ સંખ્યાને 96 તરીકે લખીએ છીએ. તે 96 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 96 के रूप में लिखते हैं। यह 96 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  96
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '97', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "97", "gu": "97", "hi": "97"}'::jsonb, 
  '/assets/svgs/numbers/97.svg', 
  '{"en": "Ninety Seven! Let''s count 97 Flowers.", "gu": "સત્તાણું! ચાલો સત્તાણું ફૂલો ગણીએ!", "hi": "सत्तानवे! आइए सत्तानवे फूल गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Flowers on this card? Counting Flowers is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા ફૂલો શોધી શકો છો? ફૂલો ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी फूल पा सकते हैं? फूल गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 97. It represents 97 items.", "gu": "આપણે આ સંખ્યાને 97 તરીકે લખીએ છીએ. તે 97 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 97 के रूप में लिखते हैं। यह 97 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  97
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '98', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "98", "gu": "98", "hi": "98"}'::jsonb, 
  '/assets/svgs/numbers/98.svg', 
  '{"en": "Ninety Eight! Let''s count 98 Coins.", "gu": "અઠ્ઠાણું! ચાલો અઠ્ઠાણું સિક્કા ગણીએ!", "hi": "अट्ठानवे! आइए अट्ठानवे सिक्के गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Coins on this card? Counting Coins is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા સિક્કા શોધી શકો છો? સિક્કા ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी सिक्के पा सकते हैं? सिक्के गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 98. It represents 98 items.", "gu": "આપણે આ સંખ્યાને 98 તરીકે લખીએ છીએ. તે 98 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 98 के रूप में लिखते हैं। यह 98 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  98
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '99', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "99", "gu": "99", "hi": "99"}'::jsonb, 
  '/assets/svgs/numbers/99.svg', 
  '{"en": "Ninety Nine! Let''s count 99 Cherries.", "gu": "નવાણું! ચાલો નવાણું ચેરી ગણીએ!", "hi": "निन्यानवे! आइए निन्यानवे ચેરી गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Cherries on this card? Counting Cherries is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા ચેરી શોધી શકો છો? ચેરી ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी ચેરી पा सकते हैं? ચેરી गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 99. It represents 99 items.", "gu": "આપણે આ સંખ્યાને 99 તરીકે લખીએ છીએ. તે 99 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 99 के रूप में लिखते हैं। यह 99 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  99
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.numbers 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  '100', 
  (SELECT id FROM categories WHERE category_key = 'numbers' LIMIT 1), 
  '{"en": "100", "gu": "100", "hi": "100"}'::jsonb, 
  '/assets/svgs/numbers/100.svg', 
  '{"en": "One Hundred! Let''s count 100 Suns.", "gu": "સો! ચાલો સો સૂરજ ગણીએ!", "hi": "सौ! आइए सौ सूरज गिनें!"}'::jsonb, 
  '{"en": "Can you find all the Suns on this card? Counting Suns is a great way to learn numbers.", "gu": "શું તમે આ કાર્ડ પરના બધા સૂરજ શોધી શકો છો? સૂરજ ગણવા એ સંખ્યાઓ શીખવાની એક સરસ રીત છે.", "hi": "क्या आप इस कार्ड पर सभी सूरज पा सकते हैं? सूरज गिनना संख्याएँ सीखने का एक शानदार तरीका है।"}'::jsonb, 
  '{"en": "We write this number as 100. It represents 100 items.", "gu": "આપણે આ સંખ્યાને 100 તરીકે લખીએ છીએ. તે 100 વસ્તુઓ દર્શાવે છે.", "hi": "हम इस संख्या को 100 के रूप में लिखते हैं। यह 100 वस्तुओं का प्रतिनिधित्व करता है।"}'::jsonb, 
  'memory', 
  true, 
  100
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;