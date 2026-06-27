-- 1. Create flags table

CREATE TABLE IF NOT EXISTS public.flags (
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
  constraint flags_pkey primary key (id),
  constraint flags_topic_key_key unique (topic_key),
  constraint flags_category_id_fkey foreign KEY (category_id) references categories (id) on delete CASCADE
) TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS idx_flags_topic_key on public.flags using btree (topic_key) TABLESPACE pg_default;

ALTER TABLE public.flags DISABLE ROW LEVEL SECURITY;

GRANT ALL ON public.flags TO anon;
GRANT ALL ON public.flags TO authenticated;
GRANT ALL ON public.flags TO service_role;


-- 2. Reset sequence & insert category

SELECT setval(
  pg_get_serial_sequence('public.categories', 'id'),
  COALESCE((SELECT MAX(id) FROM public.categories), 0) + 1,
  false
);

INSERT INTO public.categories (category_key, title, color, is_premium, group_id, display_order)
VALUES (
  'flags',
  '{"en": "Flags", "gu": "ધ્વજ", "hi": "ध्वज"}'::jsonb,
  '#7E57C2',
  false,
  'natures_world',
  24
)
ON CONFLICT (category_key) DO UPDATE SET
  title = EXCLUDED.title,
  color = EXCLUDED.color,
  group_id = EXCLUDED.group_id,
  display_order = EXCLUDED.display_order;


-- 3. Seed flag entries (254 items)

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'af',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Afghanistan","gu":"અફઘાનિસ્તાન","hi":"अफ़गानिस्तान"}'::jsonb,
  'assets/svgs/flags/af.svg',
  '{"en":"Afghanistan! Learn about the flag of Afghanistan!","gu":"અફઘાનિસ્તાન! અફઘાનિસ્તાન દેશના ધ્વજ વિશે જાણો!","hi":"अफ़गानिस्तान! अफ़गानिस्तान के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Afghanistan. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ અફઘાનિસ્તાન દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह अफ़गानिस्तान का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Afghanistan is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? અફઘાનિસ્તાન નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? अफ़गानिस्तान का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ax',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Åland Islands","gu":"ઑલેન્ડ આઇલેન્ડ્સ","hi":"एलैंड द्वीपसमूह"}'::jsonb,
  'assets/svgs/flags/ax.svg',
  '{"en":"Åland Islands! Learn about the flag of Åland Islands!","gu":"ઑલેન્ડ આઇલેન્ડ્સ! ઑલેન્ડ આઇલેન્ડ્સ દેશના ધ્વજ વિશે જાણો!","hi":"एलैंड द्वीपसमूह! एलैंड द्वीपसमूह के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Åland Islands. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ઑલેન્ડ આઇલેન્ડ્સ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह एलैंड द्वीपसमूह का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Åland Islands is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ઑલેન્ડ આઇલેન્ડ્સ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? एलैंड द्वीपसमूह का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'al',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Albania","gu":"અલ્બેનિયા","hi":"अल्बानिया"}'::jsonb,
  'assets/svgs/flags/al.svg',
  '{"en":"Albania! Learn about the flag of Albania!","gu":"અલ્બેનિયા! અલ્બેનિયા દેશના ધ્વજ વિશે જાણો!","hi":"अल्बानिया! अल्बानिया के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Albania. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ અલ્બેનિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह अल्बानिया का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Albania is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? અલ્બેનિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? अल्बानिया का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'dz',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Algeria","gu":"અલ્જીરિયા","hi":"अल्जीरिया"}'::jsonb,
  'assets/svgs/flags/dz.svg',
  '{"en":"Algeria! Learn about the flag of Algeria!","gu":"અલ્જીરિયા! અલ્જીરિયા દેશના ધ્વજ વિશે જાણો!","hi":"अल्जीरिया! अल्जीरिया के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Algeria. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ અલ્જીરિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह अल्जीरिया का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Algeria is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? અલ્જીરિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? अल्जीरिया का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'as',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"American Samoa","gu":"અમેરિકન સમોઆ","hi":"अमेरिकी समोआ"}'::jsonb,
  'assets/svgs/flags/as.svg',
  '{"en":"American Samoa! Learn about the flag of American Samoa!","gu":"અમેરિકન સમોઆ! અમેરિકન સમોઆ દેશના ધ્વજ વિશે જાણો!","hi":"अमेरिकी समोआ! अमेरिकी समोआ के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of American Samoa. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ અમેરિકન સમોઆ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह अमेरिकी समोआ का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of American Samoa is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? અમેરિકન સમોઆ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? अमेरिकी समोआ का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ad',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Andorra","gu":"ઍંડોરા","hi":"एंडोरा"}'::jsonb,
  'assets/svgs/flags/ad.svg',
  '{"en":"Andorra! Learn about the flag of Andorra!","gu":"ઍંડોરા! ઍંડોરા દેશના ધ્વજ વિશે જાણો!","hi":"एंडोरा! एंडोरा के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Andorra. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ઍંડોરા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह एंडोरा का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Andorra is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ઍંડોરા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? एंडोरा का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ao',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Angola","gu":"અંગોલા","hi":"अंगोला"}'::jsonb,
  'assets/svgs/flags/ao.svg',
  '{"en":"Angola! Learn about the flag of Angola!","gu":"અંગોલા! અંગોલા દેશના ધ્વજ વિશે જાણો!","hi":"अंगोला! अंगोला के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Angola. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ અંગોલા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह अंगोला का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Angola is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? અંગોલા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? अंगोला का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ai',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Anguilla","gu":"ઍંગ્વિલા","hi":"एंग्विला"}'::jsonb,
  'assets/svgs/flags/ai.svg',
  '{"en":"Anguilla! Learn about the flag of Anguilla!","gu":"ઍંગ્વિલા! ઍંગ્વિલા દેશના ધ્વજ વિશે જાણો!","hi":"एंग्विला! एंग्विला के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Anguilla. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ઍંગ્વિલા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह एंग्विला का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Anguilla is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ઍંગ્વિલા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? एंग्विला का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'aq',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Antarctica","gu":"એન્ટાર્કટિકા","hi":"अंटार्कटिका"}'::jsonb,
  'assets/svgs/flags/aq.svg',
  '{"en":"Antarctica! Learn about the flag of Antarctica!","gu":"એન્ટાર્કટિકા! એન્ટાર્કટિકા દેશના ધ્વજ વિશે જાણો!","hi":"अंटार्कटिका! अंटार्कटिका के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Antarctica. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ એન્ટાર્કટિકા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह अंटार्कटिका का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Antarctica is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? એન્ટાર્કટિકા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? अंटार्कटिका का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ag',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Antigua & Barbuda","gu":"ઍન્ટિગુઆ અને બર્મુડા","hi":"एंटिगुआ और बरबुडा"}'::jsonb,
  'assets/svgs/flags/ag.svg',
  '{"en":"Antigua & Barbuda! Learn about the flag of Antigua & Barbuda!","gu":"ઍન્ટિગુઆ અને બર્મુડા! ઍન્ટિગુઆ અને બર્મુડા દેશના ધ્વજ વિશે જાણો!","hi":"एंटिगुआ और बरबुडा! एंटिगुआ और बरबुडा के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Antigua & Barbuda. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ઍન્ટિગુઆ અને બર્મુડા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह एंटिगुआ और बरबुडा का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Antigua & Barbuda is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ઍન્ટિગુઆ અને બર્મુડા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? एंटिगुआ और बरबुडा का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ar',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Argentina","gu":"આર્જેન્ટીના","hi":"अर्जेंटीना"}'::jsonb,
  'assets/svgs/flags/ar.svg',
  '{"en":"Argentina! Learn about the flag of Argentina!","gu":"આર્જેન્ટીના! આર્જેન્ટીના દેશના ધ્વજ વિશે જાણો!","hi":"अर्जेंटीना! अर्जेंटीना के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Argentina. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ આર્જેન્ટીના દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह अर्जेंटीना का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Argentina is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? આર્જેન્ટીના નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? अर्जेंटीना का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'am',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Armenia","gu":"આર્મેનિયા","hi":"आर्मेनिया"}'::jsonb,
  'assets/svgs/flags/am.svg',
  '{"en":"Armenia! Learn about the flag of Armenia!","gu":"આર્મેનિયા! આર્મેનિયા દેશના ધ્વજ વિશે જાણો!","hi":"आर्मेनिया! आर्मेनिया के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Armenia. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ આર્મેનિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह आर्मेनिया का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Armenia is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? આર્મેનિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? आर्मेनिया का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'aw',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Aruba","gu":"અરુબા","hi":"अरूबा"}'::jsonb,
  'assets/svgs/flags/aw.svg',
  '{"en":"Aruba! Learn about the flag of Aruba!","gu":"અરુબા! અરુબા દેશના ધ્વજ વિશે જાણો!","hi":"अरूबा! अरूबा के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Aruba. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ અરુબા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह अरूबा का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Aruba is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? અરુબા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? अरूबा का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'au',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Australia","gu":"ઑસ્ટ્રેલિયા","hi":"ऑस्ट्रेलिया"}'::jsonb,
  'assets/svgs/flags/au.svg',
  '{"en":"Australia! Learn about the flag of Australia!","gu":"ઑસ્ટ્રેલિયા! ઑસ્ટ્રેલિયા દેશના ધ્વજ વિશે જાણો!","hi":"ऑस्ट्रेलिया! ऑस्ट्रेलिया के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Australia. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ઑસ્ટ્રેલિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह ऑस्ट्रेलिया का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Australia is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ઑસ્ટ્રેલિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? ऑस्ट्रेलिया का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'at',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Austria","gu":"ઑસ્ટ્રિયા","hi":"ऑस्ट्रिया"}'::jsonb,
  'assets/svgs/flags/at.svg',
  '{"en":"Austria! Learn about the flag of Austria!","gu":"ઑસ્ટ્રિયા! ઑસ્ટ્રિયા દેશના ધ્વજ વિશે જાણો!","hi":"ऑस्ट्रिया! ऑस्ट्रिया के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Austria. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ઑસ્ટ્રિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह ऑस्ट्रिया का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Austria is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ઑસ્ટ્રિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? ऑस्ट्रिया का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'az',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Azerbaijan","gu":"અઝરબૈજાન","hi":"अज़रबैजान"}'::jsonb,
  'assets/svgs/flags/az.svg',
  '{"en":"Azerbaijan! Learn about the flag of Azerbaijan!","gu":"અઝરબૈજાન! અઝરબૈજાન દેશના ધ્વજ વિશે જાણો!","hi":"अज़रबैजान! अज़रबैजान के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Azerbaijan. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ અઝરબૈજાન દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह अज़रबैजान का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Azerbaijan is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? અઝરબૈજાન નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? अज़रबैजान का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'bs',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Bahamas","gu":"બહામાસ","hi":"बहामास"}'::jsonb,
  'assets/svgs/flags/bs.svg',
  '{"en":"Bahamas! Learn about the flag of Bahamas!","gu":"બહામાસ! બહામાસ દેશના ધ્વજ વિશે જાણો!","hi":"बहामास! बहामास के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Bahamas. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ બહામાસ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह बहामास का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Bahamas is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? બહામાસ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? बहामास का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'bh',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Bahrain","gu":"બેહરીન","hi":"बहरीन"}'::jsonb,
  'assets/svgs/flags/bh.svg',
  '{"en":"Bahrain! Learn about the flag of Bahrain!","gu":"બેહરીન! બેહરીન દેશના ધ્વજ વિશે જાણો!","hi":"बहरीन! बहरीन के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Bahrain. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ બેહરીન દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह बहरीन का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Bahrain is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? બેહરીન નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? बहरीन का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'bd',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Bangladesh","gu":"બાંગ્લાદેશ","hi":"बांग्लादेश"}'::jsonb,
  'assets/svgs/flags/bd.svg',
  '{"en":"Bangladesh! Learn about the flag of Bangladesh!","gu":"બાંગ્લાદેશ! બાંગ્લાદેશ દેશના ધ્વજ વિશે જાણો!","hi":"बांग्लादेश! बांग्लादेश के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Bangladesh. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ બાંગ્લાદેશ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह बांग्लादेश का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Bangladesh is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? બાંગ્લાદેશ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? बांग्लादेश का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'bb',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Barbados","gu":"બારબાડોસ","hi":"बारबाडोस"}'::jsonb,
  'assets/svgs/flags/bb.svg',
  '{"en":"Barbados! Learn about the flag of Barbados!","gu":"બારબાડોસ! બારબાડોસ દેશના ધ્વજ વિશે જાણો!","hi":"बारबाडोस! बारबाडोस के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Barbados. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ બારબાડોસ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह बारबाडोस का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Barbados is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? બારબાડોસ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? बारबाडोस का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'by',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Belarus","gu":"બેલારુસ","hi":"बेलारूस"}'::jsonb,
  'assets/svgs/flags/by.svg',
  '{"en":"Belarus! Learn about the flag of Belarus!","gu":"બેલારુસ! બેલારુસ દેશના ધ્વજ વિશે જાણો!","hi":"बेलारूस! बेलारूस के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Belarus. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ બેલારુસ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह बेलारूस का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Belarus is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? બેલારુસ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? बेलारूस का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'be',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Belgium","gu":"બેલ્જીયમ","hi":"बेल्जियम"}'::jsonb,
  'assets/svgs/flags/be.svg',
  '{"en":"Belgium! Learn about the flag of Belgium!","gu":"બેલ્જીયમ! બેલ્જીયમ દેશના ધ્વજ વિશે જાણો!","hi":"बेल्जियम! बेल्जियम के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Belgium. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ બેલ્જીયમ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह बेल्जियम का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Belgium is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? બેલ્જીયમ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? बेल्जियम का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'bz',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Belize","gu":"બેલીઝ","hi":"बेलीज़"}'::jsonb,
  'assets/svgs/flags/bz.svg',
  '{"en":"Belize! Learn about the flag of Belize!","gu":"બેલીઝ! બેલીઝ દેશના ધ્વજ વિશે જાણો!","hi":"बेलीज़! बेलीज़ के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Belize. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ બેલીઝ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह बेलीज़ का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Belize is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? બેલીઝ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? बेलीज़ का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'bj',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Benin","gu":"બેનિન","hi":"बेनिन"}'::jsonb,
  'assets/svgs/flags/bj.svg',
  '{"en":"Benin! Learn about the flag of Benin!","gu":"બેનિન! બેનિન દેશના ધ્વજ વિશે જાણો!","hi":"बेनिन! बेनिन के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Benin. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ બેનિન દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह बेनिन का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Benin is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? બેનિન નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? बेनिन का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'bm',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Bermuda","gu":"બર્મુડા","hi":"बरमूडा"}'::jsonb,
  'assets/svgs/flags/bm.svg',
  '{"en":"Bermuda! Learn about the flag of Bermuda!","gu":"બર્મુડા! બર્મુડા દેશના ધ્વજ વિશે જાણો!","hi":"बरमूडा! बरमूडा के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Bermuda. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ બર્મુડા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह बरमूडा का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Bermuda is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? બર્મુડા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? बरमूडा का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'bt',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Bhutan","gu":"ભૂટાન","hi":"भूटान"}'::jsonb,
  'assets/svgs/flags/bt.svg',
  '{"en":"Bhutan! Learn about the flag of Bhutan!","gu":"ભૂટાન! ભૂટાન દેશના ધ્વજ વિશે જાણો!","hi":"भूटान! भूटान के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Bhutan. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ભૂટાન દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह भूटान का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Bhutan is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ભૂટાન નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? भूटान का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'bo',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Bolivia","gu":"બોલિવિયા","hi":"बोलीविया"}'::jsonb,
  'assets/svgs/flags/bo.svg',
  '{"en":"Bolivia! Learn about the flag of Bolivia!","gu":"બોલિવિયા! બોલિવિયા દેશના ધ્વજ વિશે જાણો!","hi":"बोलीविया! बोलीविया के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Bolivia. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ બોલિવિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह बोलीविया का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Bolivia is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? બોલિવિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? बोलीविया का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ba',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Bosnia & Herzegovina","gu":"બોસ્નિયા અને હર્ઝેગોવિના","hi":"बोस्निया और हर्ज़ेगोविना"}'::jsonb,
  'assets/svgs/flags/ba.svg',
  '{"en":"Bosnia & Herzegovina! Learn about the flag of Bosnia & Herzegovina!","gu":"બોસ્નિયા અને હર્ઝેગોવિના! બોસ્નિયા અને હર્ઝેગોવિના દેશના ધ્વજ વિશે જાણો!","hi":"बोस्निया और हर्ज़ेगोविना! बोस्निया और हर्ज़ेगोविना के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Bosnia & Herzegovina. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ બોસ્નિયા અને હર્ઝેગોવિના દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह बोस्निया और हर्ज़ेगोविना का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Bosnia & Herzegovina is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? બોસ્નિયા અને હર્ઝેગોવિના નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? बोस्निया और हर्ज़ेगोविना का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'bw',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Botswana","gu":"બોત્સ્વાના","hi":"बोत्स्वाना"}'::jsonb,
  'assets/svgs/flags/bw.svg',
  '{"en":"Botswana! Learn about the flag of Botswana!","gu":"બોત્સ્વાના! બોત્સ્વાના દેશના ધ્વજ વિશે જાણો!","hi":"बोत्स्वाना! बोत्स्वाना के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Botswana. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ બોત્સ્વાના દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह बोत्स्वाना का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Botswana is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? બોત્સ્વાના નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? बोत्स्वाना का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'bv',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Bouvet Island","gu":"બૌવેત આઇલેન્ડ","hi":"बोवेत द्वीप"}'::jsonb,
  'assets/svgs/flags/bv.svg',
  '{"en":"Bouvet Island! Learn about the flag of Bouvet Island!","gu":"બૌવેત આઇલેન્ડ! બૌવેત આઇલેન્ડ દેશના ધ્વજ વિશે જાણો!","hi":"बोवेत द्वीप! बोवेत द्वीप के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Bouvet Island. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ બૌવેત આઇલેન્ડ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह बोवेत द्वीप का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Bouvet Island is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? બૌવેત આઇલેન્ડ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? बोवेत द्वीप का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'br',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Brazil","gu":"બ્રાઝિલ","hi":"ब्राज़ील"}'::jsonb,
  'assets/svgs/flags/br.svg',
  '{"en":"Brazil! Learn about the flag of Brazil!","gu":"બ્રાઝિલ! બ્રાઝિલ દેશના ધ્વજ વિશે જાણો!","hi":"ब्राज़ील! ब्राज़ील के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Brazil. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ બ્રાઝિલ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह ब्राज़ील का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Brazil is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? બ્રાઝિલ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? ब्राज़ील का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'io',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"British Indian Ocean Territory","gu":"બ્રિટિશ ઇન્ડિયન ઓશન ટેરિટરી","hi":"ब्रिटिश हिंद महासागरीय क्षेत्र"}'::jsonb,
  'assets/svgs/flags/io.svg',
  '{"en":"British Indian Ocean Territory! Learn about the flag of British Indian Ocean Territory!","gu":"બ્રિટિશ ઇન્ડિયન ઓશન ટેરિટરી! બ્રિટિશ ઇન્ડિયન ઓશન ટેરિટરી દેશના ધ્વજ વિશે જાણો!","hi":"ब्रिटिश हिंद महासागरीय क्षेत्र! ब्रिटिश हिंद महासागरीय क्षेत्र के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of British Indian Ocean Territory. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ બ્રિટિશ ઇન્ડિયન ઓશન ટેરિટરી દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह ब्रिटिश हिंद महासागरीय क्षेत्र का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of British Indian Ocean Territory is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? બ્રિટિશ ઇન્ડિયન ઓશન ટેરિટરી નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? ब्रिटिश हिंद महासागरीय क्षेत्र का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'vg',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"British Virgin Islands","gu":"બ્રિટિશ વર્જિન આઇલેન્ડ્સ","hi":"ब्रिटिश वर्जिन द्वीपसमूह"}'::jsonb,
  'assets/svgs/flags/vg.svg',
  '{"en":"British Virgin Islands! Learn about the flag of British Virgin Islands!","gu":"બ્રિટિશ વર્જિન આઇલેન્ડ્સ! બ્રિટિશ વર્જિન આઇલેન્ડ્સ દેશના ધ્વજ વિશે જાણો!","hi":"ब्रिटिश वर्जिन द्वीपसमूह! ब्रिटिश वर्जिन द्वीपसमूह के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of British Virgin Islands. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ બ્રિટિશ વર્જિન આઇલેન્ડ્સ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह ब्रिटिश वर्जिन द्वीपसमूह का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of British Virgin Islands is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? બ્રિટિશ વર્જિન આઇલેન્ડ્સ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? ब्रिटिश वर्जिन द्वीपसमूह का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'bn',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Brunei","gu":"બ્રુનેઇ","hi":"ब्रूनेई"}'::jsonb,
  'assets/svgs/flags/bn.svg',
  '{"en":"Brunei! Learn about the flag of Brunei!","gu":"બ્રુનેઇ! બ્રુનેઇ દેશના ધ્વજ વિશે જાણો!","hi":"ब्रूनेई! ब्रूनेई के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Brunei. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ બ્રુનેઇ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह ब्रूनेई का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Brunei is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? બ્રુનેઇ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? ब्रूनेई का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'bg',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Bulgaria","gu":"બલ્ગેરિયા","hi":"बुल्गारिया"}'::jsonb,
  'assets/svgs/flags/bg.svg',
  '{"en":"Bulgaria! Learn about the flag of Bulgaria!","gu":"બલ્ગેરિયા! બલ્ગેરિયા દેશના ધ્વજ વિશે જાણો!","hi":"बुल्गारिया! बुल्गारिया के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Bulgaria. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ બલ્ગેરિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह बुल्गारिया का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Bulgaria is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? બલ્ગેરિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? बुल्गारिया का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'bf',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Burkina Faso","gu":"બુર્કિના ફાસો","hi":"बुर्किना फ़ासो"}'::jsonb,
  'assets/svgs/flags/bf.svg',
  '{"en":"Burkina Faso! Learn about the flag of Burkina Faso!","gu":"બુર્કિના ફાસો! બુર્કિના ફાસો દેશના ધ્વજ વિશે જાણો!","hi":"बुर्किना फ़ासो! बुर्किना फ़ासो के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Burkina Faso. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ બુર્કિના ફાસો દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह बुर्किना फ़ासो का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Burkina Faso is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? બુર્કિના ફાસો નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? बुर्किना फ़ासो का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'bi',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Burundi","gu":"બુરુંડી","hi":"बुरुंडी"}'::jsonb,
  'assets/svgs/flags/bi.svg',
  '{"en":"Burundi! Learn about the flag of Burundi!","gu":"બુરુંડી! બુરુંડી દેશના ધ્વજ વિશે જાણો!","hi":"बुरुंडी! बुरुंडी के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Burundi. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ બુરુંડી દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह बुरुंडी का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Burundi is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? બુરુંડી નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? बुरुंडी का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'kh',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Cambodia","gu":"કંબોડિયા","hi":"कंबोडिया"}'::jsonb,
  'assets/svgs/flags/kh.svg',
  '{"en":"Cambodia! Learn about the flag of Cambodia!","gu":"કંબોડિયા! કંબોડિયા દેશના ધ્વજ વિશે જાણો!","hi":"कंबोडिया! कंबोडिया के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Cambodia. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ કંબોડિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह कंबोडिया का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Cambodia is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? કંબોડિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? कंबोडिया का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'cm',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Cameroon","gu":"કૅમરૂન","hi":"कैमरून"}'::jsonb,
  'assets/svgs/flags/cm.svg',
  '{"en":"Cameroon! Learn about the flag of Cameroon!","gu":"કૅમરૂન! કૅમરૂન દેશના ધ્વજ વિશે જાણો!","hi":"कैमरून! कैमरून के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Cameroon. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ કૅમરૂન દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह कैमरून का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Cameroon is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? કૅમરૂન નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? कैमरून का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ca',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Canada","gu":"કેનેડા","hi":"कनाडा"}'::jsonb,
  'assets/svgs/flags/ca.svg',
  '{"en":"Canada! Learn about the flag of Canada!","gu":"કેનેડા! કેનેડા દેશના ધ્વજ વિશે જાણો!","hi":"कनाडा! कनाडा के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Canada. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ કેનેડા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह कनाडा का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Canada is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? કેનેડા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? कनाडा का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'cv',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Cape Verde","gu":"કૅપ વર્ડે","hi":"केप वर्ड"}'::jsonb,
  'assets/svgs/flags/cv.svg',
  '{"en":"Cape Verde! Learn about the flag of Cape Verde!","gu":"કૅપ વર્ડે! કૅપ વર્ડે દેશના ધ્વજ વિશે જાણો!","hi":"केप वर्ड! केप वर्ड के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Cape Verde. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ કૅપ વર્ડે દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह केप वर्ड का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Cape Verde is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? કૅપ વર્ડે નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? केप वर्ड का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'bq',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Caribbean Netherlands","gu":"કેરેબિયન નેધરલેન્ડ્ઝ","hi":"कैरिबियन नीदरलैंड"}'::jsonb,
  'assets/svgs/flags/bq.svg',
  '{"en":"Caribbean Netherlands! Learn about the flag of Caribbean Netherlands!","gu":"કેરેબિયન નેધરલેન્ડ્ઝ! કેરેબિયન નેધરલેન્ડ્ઝ દેશના ધ્વજ વિશે જાણો!","hi":"कैरिबियन नीदरलैंड! कैरिबियन नीदरलैंड के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Caribbean Netherlands. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ કેરેબિયન નેધરલેન્ડ્ઝ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह कैरिबियन नीदरलैंड का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Caribbean Netherlands is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? કેરેબિયન નેધરલેન્ડ્ઝ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? कैरिबियन नीदरलैंड का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ky',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Cayman Islands","gu":"કેમેન આઇલેન્ડ્સ","hi":"कैमेन द्वीपसमूह"}'::jsonb,
  'assets/svgs/flags/ky.svg',
  '{"en":"Cayman Islands! Learn about the flag of Cayman Islands!","gu":"કેમેન આઇલેન્ડ્સ! કેમેન આઇલેન્ડ્સ દેશના ધ્વજ વિશે જાણો!","hi":"कैमेन द्वीपसमूह! कैमेन द्वीपसमूह के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Cayman Islands. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ કેમેન આઇલેન્ડ્સ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह कैमेन द्वीपसमूह का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Cayman Islands is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? કેમેન આઇલેન્ડ્સ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? कैमेन द्वीपसमूह का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'cf',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Central African Republic","gu":"સેન્ટ્રલ આફ્રિકન રિપબ્લિક","hi":"मध्य अफ़्रीकी गणराज्य"}'::jsonb,
  'assets/svgs/flags/cf.svg',
  '{"en":"Central African Republic! Learn about the flag of Central African Republic!","gu":"સેન્ટ્રલ આફ્રિકન રિપબ્લિક! સેન્ટ્રલ આફ્રિકન રિપબ્લિક દેશના ધ્વજ વિશે જાણો!","hi":"मध्य अफ़्रीकी गणराज्य! मध्य अफ़्रीकी गणराज्य के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Central African Republic. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ સેન્ટ્રલ આફ્રિકન રિપબ્લિક દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह मध्य अफ़्रीकी गणराज्य का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Central African Republic is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? સેન્ટ્રલ આફ્રિકન રિપબ્લિક નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? मध्य अफ़्रीकी गणराज्य का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'td',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Chad","gu":"ચાડ","hi":"चाड"}'::jsonb,
  'assets/svgs/flags/td.svg',
  '{"en":"Chad! Learn about the flag of Chad!","gu":"ચાડ! ચાડ દેશના ધ્વજ વિશે જાણો!","hi":"चाड! चाड के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Chad. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ચાડ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह चाड का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Chad is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ચાડ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? चाड का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'cl',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Chile","gu":"ચિલી","hi":"चिली"}'::jsonb,
  'assets/svgs/flags/cl.svg',
  '{"en":"Chile! Learn about the flag of Chile!","gu":"ચિલી! ચિલી દેશના ધ્વજ વિશે જાણો!","hi":"चिली! चिली के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Chile. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ચિલી દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह चिली का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Chile is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ચિલી નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? चिली का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'cn',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"China","gu":"ચીન","hi":"चीन"}'::jsonb,
  'assets/svgs/flags/cn.svg',
  '{"en":"China! Learn about the flag of China!","gu":"ચીન! ચીન દેશના ધ્વજ વિશે જાણો!","hi":"चीन! चीन के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of China. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ચીન દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह चीन का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of China is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ચીન નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? चीन का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'cx',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Christmas Island","gu":"ક્રિસમસ આઇલેન્ડ","hi":"क्रिसमस द्वीप"}'::jsonb,
  'assets/svgs/flags/cx.svg',
  '{"en":"Christmas Island! Learn about the flag of Christmas Island!","gu":"ક્રિસમસ આઇલેન્ડ! ક્રિસમસ આઇલેન્ડ દેશના ધ્વજ વિશે જાણો!","hi":"क्रिसमस द्वीप! क्रिसमस द्वीप के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Christmas Island. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ક્રિસમસ આઇલેન્ડ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह क्रिसमस द्वीप का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Christmas Island is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ક્રિસમસ આઇલેન્ડ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? क्रिसमस द्वीप का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'cc',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Cocos","gu":"કોકોઝ","hi":"कोकोस"}'::jsonb,
  'assets/svgs/flags/cc.svg',
  '{"en":"Cocos! Learn about the flag of Cocos!","gu":"કોકોઝ! કોકોઝ દેશના ધ્વજ વિશે જાણો!","hi":"कोकोस! कोकोस के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Cocos. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ કોકોઝ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह कोकोस का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Cocos is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? કોકોઝ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? कोकोस का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'co',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Colombia","gu":"કોલમ્બિયા","hi":"कोलंबिया"}'::jsonb,
  'assets/svgs/flags/co.svg',
  '{"en":"Colombia! Learn about the flag of Colombia!","gu":"કોલમ્બિયા! કોલમ્બિયા દેશના ધ્વજ વિશે જાણો!","hi":"कोलंबिया! कोलंबिया के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Colombia. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ કોલમ્બિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह कोलंबिया का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Colombia is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? કોલમ્બિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? कोलंबिया का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'km',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Comoros","gu":"કોમોરસ","hi":"कोमोरोस"}'::jsonb,
  'assets/svgs/flags/km.svg',
  '{"en":"Comoros! Learn about the flag of Comoros!","gu":"કોમોરસ! કોમોરસ દેશના ધ્વજ વિશે જાણો!","hi":"कोमोरोस! कोमोरोस के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Comoros. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ કોમોરસ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह कोमोरोस का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Comoros is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? કોમોરસ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? कोमोरोस का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'cg',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Congo - Brazzaville","gu":"કોંગો - બ્રાઝાવિલે","hi":"कांगो – ब्राज़ाविल"}'::jsonb,
  'assets/svgs/flags/cg.svg',
  '{"en":"Congo - Brazzaville! Learn about the flag of Congo - Brazzaville!","gu":"કોંગો - બ્રાઝાવિલે! કોંગો - બ્રાઝાવિલે દેશના ધ્વજ વિશે જાણો!","hi":"कांगो – ब्राज़ाविल! कांगो – ब्राज़ाविल के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Congo - Brazzaville. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ કોંગો - બ્રાઝાવિલે દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह कांगो – ब्राज़ाविल का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Congo - Brazzaville is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? કોંગો - બ્રાઝાવિલે નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? कांगो – ब्राज़ाविल का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'cd',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Congo - Kinshasa","gu":"કોંગો - કિંશાસા","hi":"कांगो - किंशासा"}'::jsonb,
  'assets/svgs/flags/cd.svg',
  '{"en":"Congo - Kinshasa! Learn about the flag of Congo - Kinshasa!","gu":"કોંગો - કિંશાસા! કોંગો - કિંશાસા દેશના ધ્વજ વિશે જાણો!","hi":"कांगो - किंशासा! कांगो - किंशासा के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Congo - Kinshasa. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ કોંગો - કિંશાસા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह कांगो - किंशासा का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Congo - Kinshasa is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? કોંગો - કિંશાસા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? कांगो - किंशासा का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ck',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Cook Islands","gu":"કુક આઇલેન્ડ્સ","hi":"कुक द्वीपसमूह"}'::jsonb,
  'assets/svgs/flags/ck.svg',
  '{"en":"Cook Islands! Learn about the flag of Cook Islands!","gu":"કુક આઇલેન્ડ્સ! કુક આઇલેન્ડ્સ દેશના ધ્વજ વિશે જાણો!","hi":"कुक द्वीपसमूह! कुक द्वीपसमूह के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Cook Islands. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ કુક આઇલેન્ડ્સ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह कुक द्वीपसमूह का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Cook Islands is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? કુક આઇલેન્ડ્સ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? कुक द्वीपसमूह का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'cr',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Costa Rica","gu":"કોસ્ટા રિકા","hi":"कोस्टारिका"}'::jsonb,
  'assets/svgs/flags/cr.svg',
  '{"en":"Costa Rica! Learn about the flag of Costa Rica!","gu":"કોસ્ટા રિકા! કોસ્ટા રિકા દેશના ધ્વજ વિશે જાણો!","hi":"कोस्टारिका! कोस्टारिका के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Costa Rica. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ કોસ્ટા રિકા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह कोस्टारिका का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Costa Rica is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? કોસ્ટા રિકા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? कोस्टारिका का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ci',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Côte d’Ivoire","gu":"કોટ ડીઆઇવરી","hi":"कोट डी आइवर"}'::jsonb,
  'assets/svgs/flags/ci.svg',
  '{"en":"Côte d’Ivoire! Learn about the flag of Côte d’Ivoire!","gu":"કોટ ડીઆઇવરી! કોટ ડીઆઇવરી દેશના ધ્વજ વિશે જાણો!","hi":"कोट डी आइवर! कोट डी आइवर के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Côte d’Ivoire. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ કોટ ડીઆઇવરી દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह कोट डी आइवर का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Côte d’Ivoire is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? કોટ ડીઆઇવરી નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? कोट डी आइवर का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'hr',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Croatia","gu":"ક્રોએશિયા","hi":"क्रोएशिया"}'::jsonb,
  'assets/svgs/flags/hr.svg',
  '{"en":"Croatia! Learn about the flag of Croatia!","gu":"ક્રોએશિયા! ક્રોએશિયા દેશના ધ્વજ વિશે જાણો!","hi":"क्रोएशिया! क्रोएशिया के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Croatia. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ક્રોએશિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह क्रोएशिया का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Croatia is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ક્રોએશિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? क्रोएशिया का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'cu',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Cuba","gu":"ક્યુબા","hi":"क्यूबा"}'::jsonb,
  'assets/svgs/flags/cu.svg',
  '{"en":"Cuba! Learn about the flag of Cuba!","gu":"ક્યુબા! ક્યુબા દેશના ધ્વજ વિશે જાણો!","hi":"क्यूबा! क्यूबा के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Cuba. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ક્યુબા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह क्यूबा का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Cuba is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ક્યુબા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? क्यूबा का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'cw',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Curaçao","gu":"ક્યુરાસાઓ","hi":"क्यूरासाओ"}'::jsonb,
  'assets/svgs/flags/cw.svg',
  '{"en":"Curaçao! Learn about the flag of Curaçao!","gu":"ક્યુરાસાઓ! ક્યુરાસાઓ દેશના ધ્વજ વિશે જાણો!","hi":"क्यूरासाओ! क्यूरासाओ के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Curaçao. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ક્યુરાસાઓ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह क्यूरासाओ का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Curaçao is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ક્યુરાસાઓ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? क्यूरासाओ का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'cy',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Cyprus","gu":"સાયપ્રસ","hi":"साइप्रस"}'::jsonb,
  'assets/svgs/flags/cy.svg',
  '{"en":"Cyprus! Learn about the flag of Cyprus!","gu":"સાયપ્રસ! સાયપ્રસ દેશના ધ્વજ વિશે જાણો!","hi":"साइप्रस! साइप्रस के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Cyprus. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ સાયપ્રસ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह साइप्रस का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Cyprus is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? સાયપ્રસ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? साइप्रस का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'cz',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Czechia","gu":"ચેકીયા","hi":"चेकिया"}'::jsonb,
  'assets/svgs/flags/cz.svg',
  '{"en":"Czechia! Learn about the flag of Czechia!","gu":"ચેકીયા! ચેકીયા દેશના ધ્વજ વિશે જાણો!","hi":"चेकिया! चेकिया के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Czechia. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ચેકીયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह चेकिया का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Czechia is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ચેકીયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? चेकिया का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'dk',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Denmark","gu":"ડેનમાર્ક","hi":"डेनमार्क"}'::jsonb,
  'assets/svgs/flags/dk.svg',
  '{"en":"Denmark! Learn about the flag of Denmark!","gu":"ડેનમાર્ક! ડેનમાર્ક દેશના ધ્વજ વિશે જાણો!","hi":"डेनमार्क! डेनमार्क के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Denmark. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ડેનમાર્ક દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह डेनमार्क का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Denmark is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ડેનમાર્ક નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? डेनमार्क का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'dj',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Djibouti","gu":"જીબૌટી","hi":"जिबूती"}'::jsonb,
  'assets/svgs/flags/dj.svg',
  '{"en":"Djibouti! Learn about the flag of Djibouti!","gu":"જીબૌટી! જીબૌટી દેશના ધ્વજ વિશે જાણો!","hi":"जिबूती! जिबूती के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Djibouti. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ જીબૌટી દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह जिबूती का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Djibouti is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? જીબૌટી નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? जिबूती का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'dm',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Dominica","gu":"ડોમિનિકા","hi":"डोमिनिका"}'::jsonb,
  'assets/svgs/flags/dm.svg',
  '{"en":"Dominica! Learn about the flag of Dominica!","gu":"ડોમિનિકા! ડોમિનિકા દેશના ધ્વજ વિશે જાણો!","hi":"डोमिनिका! डोमिनिका के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Dominica. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ડોમિનિકા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह डोमिनिका का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Dominica is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ડોમિનિકા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? डोमिनिका का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'do',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Dominican Republic","gu":"ડોમિનિકન રિપબ્લિક","hi":"डोमिनिकन गणराज्य"}'::jsonb,
  'assets/svgs/flags/do.svg',
  '{"en":"Dominican Republic! Learn about the flag of Dominican Republic!","gu":"ડોમિનિકન રિપબ્લિક! ડોમિનિકન રિપબ્લિક દેશના ધ્વજ વિશે જાણો!","hi":"डोमिनिकन गणराज्य! डोमिनिकन गणराज्य के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Dominican Republic. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ડોમિનિકન રિપબ્લિક દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह डोमिनिकन गणराज्य का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Dominican Republic is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ડોમિનિકન રિપબ્લિક નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? डोमिनिकन गणराज्य का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ec',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Ecuador","gu":"એક્વાડોર","hi":"इक्वाडोर"}'::jsonb,
  'assets/svgs/flags/ec.svg',
  '{"en":"Ecuador! Learn about the flag of Ecuador!","gu":"એક્વાડોર! એક્વાડોર દેશના ધ્વજ વિશે જાણો!","hi":"इक्वाडोर! इक्वाडोर के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Ecuador. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ એક્વાડોર દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह इक्वाडोर का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Ecuador is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? એક્વાડોર નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? इक्वाडोर का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'eg',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Egypt","gu":"ઇજિપ્ત","hi":"मिस्र"}'::jsonb,
  'assets/svgs/flags/eg.svg',
  '{"en":"Egypt! Learn about the flag of Egypt!","gu":"ઇજિપ્ત! ઇજિપ્ત દેશના ધ્વજ વિશે જાણો!","hi":"मिस्र! मिस्र के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Egypt. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ઇજિપ્ત દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह मिस्र का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Egypt is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ઇજિપ્ત નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? मिस्र का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'sv',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"El Salvador","gu":"એલ સેલ્વાડોર","hi":"अल सल्वाडोर"}'::jsonb,
  'assets/svgs/flags/sv.svg',
  '{"en":"El Salvador! Learn about the flag of El Salvador!","gu":"એલ સેલ્વાડોર! એલ સેલ્વાડોર દેશના ધ્વજ વિશે જાણો!","hi":"अल सल्वाडोर! अल सल्वाडोर के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of El Salvador. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ એલ સેલ્વાડોર દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह अल सल्वाडोर का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of El Salvador is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? એલ સેલ્વાડોર નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? अल सल्वाडोर का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'gb-eng',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"England","gu":"ઇંગ્લેન્ડ","hi":"इंग्लैंड"}'::jsonb,
  'assets/svgs/flags/gb-eng.svg',
  '{"en":"England! Learn about the flag of England!","gu":"ઇંગ્લેન્ડ! ઇંગ્લેન્ડ દેશના ધ્વજ વિશે જાણો!","hi":"इंग्लैंड! इंग्लैंड के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of England. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ઇંગ્લેન્ડ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह इंग्लैंड का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of England is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ઇંગ્લેન્ડ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? इंग्लैंड का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'gq',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Equatorial Guinea","gu":"ઇક્વેટોરિયલ ગિની","hi":"इक्वेटोरियल गिनी"}'::jsonb,
  'assets/svgs/flags/gq.svg',
  '{"en":"Equatorial Guinea! Learn about the flag of Equatorial Guinea!","gu":"ઇક્વેટોરિયલ ગિની! ઇક્વેટોરિયલ ગિની દેશના ધ્વજ વિશે જાણો!","hi":"इक्वेटोरियल गिनी! इक्वेटोरियल गिनी के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Equatorial Guinea. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ઇક્વેટોરિયલ ગિની દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह इक्वेटोरियल गिनी का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Equatorial Guinea is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ઇક્વેટોરિયલ ગિની નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? इक्वेटोरियल गिनी का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'er',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Eritrea","gu":"એરિટ્રિયા","hi":"इरिट्रिया"}'::jsonb,
  'assets/svgs/flags/er.svg',
  '{"en":"Eritrea! Learn about the flag of Eritrea!","gu":"એરિટ્રિયા! એરિટ્રિયા દેશના ધ્વજ વિશે જાણો!","hi":"इरिट्रिया! इरिट्रिया के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Eritrea. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ એરિટ્રિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह इरिट्रिया का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Eritrea is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? એરિટ્રિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? इरिट्रिया का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ee',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Estonia","gu":"એસ્ટોનિયા","hi":"एस्टोनिया"}'::jsonb,
  'assets/svgs/flags/ee.svg',
  '{"en":"Estonia! Learn about the flag of Estonia!","gu":"એસ્ટોનિયા! એસ્ટોનિયા દેશના ધ્વજ વિશે જાણો!","hi":"एस्टोनिया! एस्टोनिया के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Estonia. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ એસ્ટોનિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह एस्टोनिया का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Estonia is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? એસ્ટોનિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? एस्टोनिया का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'sz',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Eswatini","gu":"એસ્વાટીની","hi":"स्वाज़ीलैंड"}'::jsonb,
  'assets/svgs/flags/sz.svg',
  '{"en":"Eswatini! Learn about the flag of Eswatini!","gu":"એસ્વાટીની! એસ્વાટીની દેશના ધ્વજ વિશે જાણો!","hi":"स्वाज़ीलैंड! स्वाज़ीलैंड के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Eswatini. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ એસ્વાટીની દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह स्वाज़ीलैंड का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Eswatini is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? એસ્વાટીની નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? स्वाज़ीलैंड का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'et',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Ethiopia","gu":"ઇથિઓપિયા","hi":"इथियोपिया"}'::jsonb,
  'assets/svgs/flags/et.svg',
  '{"en":"Ethiopia! Learn about the flag of Ethiopia!","gu":"ઇથિઓપિયા! ઇથિઓપિયા દેશના ધ્વજ વિશે જાણો!","hi":"इथियोपिया! इथियोपिया के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Ethiopia. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ઇથિઓપિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह इथियोपिया का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Ethiopia is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ઇથિઓપિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? इथियोपिया का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'fk',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Falkland Islands","gu":"ફૉકલેન્ડ આઇલેન્ડ્સ","hi":"फ़ॉकलैंड द्वीपसमूह"}'::jsonb,
  'assets/svgs/flags/fk.svg',
  '{"en":"Falkland Islands! Learn about the flag of Falkland Islands!","gu":"ફૉકલેન્ડ આઇલેન્ડ્સ! ફૉકલેન્ડ આઇલેન્ડ્સ દેશના ધ્વજ વિશે જાણો!","hi":"फ़ॉकलैंड द्वीपसमूह! फ़ॉकलैंड द्वीपसमूह के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Falkland Islands. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ફૉકલેન્ડ આઇલેન્ડ્સ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह फ़ॉकलैंड द्वीपसमूह का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Falkland Islands is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ફૉકલેન્ડ આઇલેન્ડ્સ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? फ़ॉकलैंड द्वीपसमूह का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'fo',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Faroe Islands","gu":"ફેરો આઇલેન્ડ્સ","hi":"फ़ेरो द्वीपसमूह"}'::jsonb,
  'assets/svgs/flags/fo.svg',
  '{"en":"Faroe Islands! Learn about the flag of Faroe Islands!","gu":"ફેરો આઇલેન્ડ્સ! ફેરો આઇલેન્ડ્સ દેશના ધ્વજ વિશે જાણો!","hi":"फ़ेरो द्वीपसमूह! फ़ेरो द्वीपसमूह के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Faroe Islands. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ફેરો આઇલેન્ડ્સ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह फ़ेरो द्वीपसमूह का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Faroe Islands is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ફેરો આઇલેન્ડ્સ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? फ़ेरो द्वीपसमूह का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'fj',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Fiji","gu":"ફીજી","hi":"फ़िजी"}'::jsonb,
  'assets/svgs/flags/fj.svg',
  '{"en":"Fiji! Learn about the flag of Fiji!","gu":"ફીજી! ફીજી દેશના ધ્વજ વિશે જાણો!","hi":"फ़िजी! फ़िजी के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Fiji. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ફીજી દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह फ़िजी का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Fiji is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ફીજી નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? फ़िजी का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'fi',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Finland","gu":"ફિનલેન્ડ","hi":"फ़िनलैंड"}'::jsonb,
  'assets/svgs/flags/fi.svg',
  '{"en":"Finland! Learn about the flag of Finland!","gu":"ફિનલેન્ડ! ફિનલેન્ડ દેશના ધ્વજ વિશે જાણો!","hi":"फ़िनलैंड! फ़िनलैंड के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Finland. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ફિનલેન્ડ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह फ़िनलैंड का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Finland is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ફિનલેન્ડ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? फ़िनलैंड का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'fr',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"France","gu":"ફ્રાંસ","hi":"फ़्रांस"}'::jsonb,
  'assets/svgs/flags/fr.svg',
  '{"en":"France! Learn about the flag of France!","gu":"ફ્રાંસ! ફ્રાંસ દેશના ધ્વજ વિશે જાણો!","hi":"फ़्रांस! फ़्रांस के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of France. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ફ્રાંસ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह फ़्रांस का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of France is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ફ્રાંસ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? फ़्रांस का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'gf',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"French Guiana","gu":"ફ્રેંચ ગયાના","hi":"फ़्रेंच गुयाना"}'::jsonb,
  'assets/svgs/flags/gf.svg',
  '{"en":"French Guiana! Learn about the flag of French Guiana!","gu":"ફ્રેંચ ગયાના! ફ્રેંચ ગયાના દેશના ધ્વજ વિશે જાણો!","hi":"फ़्रेंच गुयाना! फ़्रेंच गुयाना के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of French Guiana. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ફ્રેંચ ગયાના દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह फ़्रेंच गुयाना का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of French Guiana is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ફ્રેંચ ગયાના નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? फ़्रेंच गुयाना का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'pf',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"French Polynesia","gu":"ફ્રેંચ પોલિનેશિયા","hi":"फ़्रेंच पोलिनेशिया"}'::jsonb,
  'assets/svgs/flags/pf.svg',
  '{"en":"French Polynesia! Learn about the flag of French Polynesia!","gu":"ફ્રેંચ પોલિનેશિયા! ફ્રેંચ પોલિનેશિયા દેશના ધ્વજ વિશે જાણો!","hi":"फ़्रेंच पोलिनेशिया! फ़्रेंच पोलिनेशिया के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of French Polynesia. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ફ્રેંચ પોલિનેશિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह फ़्रेंच पोलिनेशिया का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of French Polynesia is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ફ્રેંચ પોલિનેશિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? फ़्रेंच पोलिनेशिया का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'tf',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"French Southern Territories","gu":"ફ્રેંચ સધર્ન ટેરિટરીઝ","hi":"फ़्रांसीसी दक्षिणी क्षेत्र"}'::jsonb,
  'assets/svgs/flags/tf.svg',
  '{"en":"French Southern Territories! Learn about the flag of French Southern Territories!","gu":"ફ્રેંચ સધર્ન ટેરિટરીઝ! ફ્રેંચ સધર્ન ટેરિટરીઝ દેશના ધ્વજ વિશે જાણો!","hi":"फ़्रांसीसी दक्षिणी क्षेत्र! फ़्रांसीसी दक्षिणी क्षेत्र के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of French Southern Territories. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ફ્રેંચ સધર્ન ટેરિટરીઝ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह फ़्रांसीसी दक्षिणी क्षेत्र का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of French Southern Territories is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ફ્રેંચ સધર્ન ટેરિટરીઝ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? फ़्रांसीसी दक्षिणी क्षेत्र का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ga',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Gabon","gu":"ગેબન","hi":"गैबॉन"}'::jsonb,
  'assets/svgs/flags/ga.svg',
  '{"en":"Gabon! Learn about the flag of Gabon!","gu":"ગેબન! ગેબન દેશના ધ્વજ વિશે જાણો!","hi":"गैबॉन! गैबॉन के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Gabon. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ગેબન દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह गैबॉन का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Gabon is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ગેબન નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? गैबॉन का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'gm',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Gambia","gu":"ગેમ્બિયા","hi":"गाम्बिया"}'::jsonb,
  'assets/svgs/flags/gm.svg',
  '{"en":"Gambia! Learn about the flag of Gambia!","gu":"ગેમ્બિયા! ગેમ્બિયા દેશના ધ્વજ વિશે જાણો!","hi":"गाम्बिया! गाम्बिया के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Gambia. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ગેમ્બિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह गाम्बिया का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Gambia is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ગેમ્બિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? गाम्बिया का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ge',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Georgia","gu":"જ્યોર્જિયા","hi":"जॉर्जिया"}'::jsonb,
  'assets/svgs/flags/ge.svg',
  '{"en":"Georgia! Learn about the flag of Georgia!","gu":"જ્યોર્જિયા! જ્યોર્જિયા દેશના ધ્વજ વિશે જાણો!","hi":"जॉर्जिया! जॉर्जिया के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Georgia. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ જ્યોર્જિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह जॉर्जिया का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Georgia is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? જ્યોર્જિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? जॉर्जिया का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'de',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Germany","gu":"જર્મની","hi":"जर्मनी"}'::jsonb,
  'assets/svgs/flags/de.svg',
  '{"en":"Germany! Learn about the flag of Germany!","gu":"જર્મની! જર્મની દેશના ધ્વજ વિશે જાણો!","hi":"जर्मनी! जर्मनी के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Germany. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ જર્મની દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह जर्मनी का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Germany is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? જર્મની નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? जर्मनी का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'gh',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Ghana","gu":"ઘાના","hi":"घाना"}'::jsonb,
  'assets/svgs/flags/gh.svg',
  '{"en":"Ghana! Learn about the flag of Ghana!","gu":"ઘાના! ઘાના દેશના ધ્વજ વિશે જાણો!","hi":"घाना! घाना के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Ghana. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ઘાના દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह घाना का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Ghana is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ઘાના નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? घाना का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'gi',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Gibraltar","gu":"જીબ્રાલ્ટર","hi":"जिब्राल्टर"}'::jsonb,
  'assets/svgs/flags/gi.svg',
  '{"en":"Gibraltar! Learn about the flag of Gibraltar!","gu":"જીબ્રાલ્ટર! જીબ્રાલ્ટર દેશના ધ્વજ વિશે જાણો!","hi":"जिब्राल्टर! जिब्राल्टर के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Gibraltar. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ જીબ્રાલ્ટર દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह जिब्राल्टर का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Gibraltar is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? જીબ્રાલ્ટર નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? जिब्राल्टर का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'gr',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Greece","gu":"ગ્રીસ","hi":"यूनान"}'::jsonb,
  'assets/svgs/flags/gr.svg',
  '{"en":"Greece! Learn about the flag of Greece!","gu":"ગ્રીસ! ગ્રીસ દેશના ધ્વજ વિશે જાણો!","hi":"यूनान! यूनान के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Greece. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ગ્રીસ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह यूनान का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Greece is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ગ્રીસ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? यूनान का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'gl',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Greenland","gu":"ગ્રીનલેન્ડ","hi":"ग्रीनलैंड"}'::jsonb,
  'assets/svgs/flags/gl.svg',
  '{"en":"Greenland! Learn about the flag of Greenland!","gu":"ગ્રીનલેન્ડ! ગ્રીનલેન્ડ દેશના ધ્વજ વિશે જાણો!","hi":"ग्रीनलैंड! ग्रीनलैंड के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Greenland. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ગ્રીનલેન્ડ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह ग्रीनलैंड का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Greenland is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ગ્રીનલેન્ડ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? ग्रीनलैंड का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'gd',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Grenada","gu":"ગ્રેનેડા","hi":"ग्रेनाडा"}'::jsonb,
  'assets/svgs/flags/gd.svg',
  '{"en":"Grenada! Learn about the flag of Grenada!","gu":"ગ્રેનેડા! ગ્રેનેડા દેશના ધ્વજ વિશે જાણો!","hi":"ग्रेनाडा! ग्रेनाडा के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Grenada. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ગ્રેનેડા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह ग्रेनाडा का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Grenada is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ગ્રેનેડા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? ग्रेनाडा का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'gp',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Guadeloupe","gu":"ગ્વાડેલોપ","hi":"ग्वाडेलूप"}'::jsonb,
  'assets/svgs/flags/gp.svg',
  '{"en":"Guadeloupe! Learn about the flag of Guadeloupe!","gu":"ગ્વાડેલોપ! ગ્વાડેલોપ દેશના ધ્વજ વિશે જાણો!","hi":"ग्वाडेलूप! ग्वाडेलूप के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Guadeloupe. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ગ્વાડેલોપ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह ग्वाडेलूप का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Guadeloupe is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ગ્વાડેલોપ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? ग्वाडेलूप का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'gu',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Guam","gu":"ગ્વામ","hi":"गुआम"}'::jsonb,
  'assets/svgs/flags/gu.svg',
  '{"en":"Guam! Learn about the flag of Guam!","gu":"ગ્વામ! ગ્વામ દેશના ધ્વજ વિશે જાણો!","hi":"गुआम! गुआम के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Guam. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ગ્વામ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह गुआम का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Guam is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ગ્વામ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? गुआम का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'gt',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Guatemala","gu":"ગ્વાટેમાલા","hi":"ग्वाटेमाला"}'::jsonb,
  'assets/svgs/flags/gt.svg',
  '{"en":"Guatemala! Learn about the flag of Guatemala!","gu":"ગ્વાટેમાલા! ગ્વાટેમાલા દેશના ધ્વજ વિશે જાણો!","hi":"ग्वाटेमाला! ग्वाटेमाला के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Guatemala. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ગ્વાટેમાલા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह ग्वाटेमाला का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Guatemala is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ગ્વાટેમાલા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? ग्वाटेमाला का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'gg',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Guernsey","gu":"ગ્વેર્નસે","hi":"गर्नसी"}'::jsonb,
  'assets/svgs/flags/gg.svg',
  '{"en":"Guernsey! Learn about the flag of Guernsey!","gu":"ગ્વેર્નસે! ગ્વેર્નસે દેશના ધ્વજ વિશે જાણો!","hi":"गर्नसी! गर्नसी के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Guernsey. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ગ્વેર્નસે દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह गर्नसी का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Guernsey is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ગ્વેર્નસે નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? गर्नसी का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'gn',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Guinea","gu":"ગિની","hi":"गिनी"}'::jsonb,
  'assets/svgs/flags/gn.svg',
  '{"en":"Guinea! Learn about the flag of Guinea!","gu":"ગિની! ગિની દેશના ધ્વજ વિશે જાણો!","hi":"गिनी! गिनी के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Guinea. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ગિની દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह गिनी का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Guinea is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ગિની નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? गिनी का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'gw',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Guinea-Bissau","gu":"ગિની-બિસાઉ","hi":"गिनी-बिसाउ"}'::jsonb,
  'assets/svgs/flags/gw.svg',
  '{"en":"Guinea-Bissau! Learn about the flag of Guinea-Bissau!","gu":"ગિની-બિસાઉ! ગિની-બિસાઉ દેશના ધ્વજ વિશે જાણો!","hi":"गिनी-बिसाउ! गिनी-बिसाउ के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Guinea-Bissau. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ગિની-બિસાઉ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह गिनी-बिसाउ का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Guinea-Bissau is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ગિની-બિસાઉ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? गिनी-बिसाउ का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'gy',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Guyana","gu":"ગયાના","hi":"गुयाना"}'::jsonb,
  'assets/svgs/flags/gy.svg',
  '{"en":"Guyana! Learn about the flag of Guyana!","gu":"ગયાના! ગયાના દેશના ધ્વજ વિશે જાણો!","hi":"गुयाना! गुयाना के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Guyana. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ગયાના દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह गुयाना का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Guyana is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ગયાના નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? गुयाना का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ht',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Haiti","gu":"હૈતિ","hi":"हैती"}'::jsonb,
  'assets/svgs/flags/ht.svg',
  '{"en":"Haiti! Learn about the flag of Haiti!","gu":"હૈતિ! હૈતિ દેશના ધ્વજ વિશે જાણો!","hi":"हैती! हैती के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Haiti. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ હૈતિ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह हैती का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Haiti is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? હૈતિ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? हैती का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'hm',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Heard & McDonald Islands","gu":"હર્ડ અને મેકડોનાલ્ડ આઇલેન્ડ્સ","hi":"हर्ड द्वीप और मैकडोनॉल्ड द्वीपसमूह"}'::jsonb,
  'assets/svgs/flags/hm.svg',
  '{"en":"Heard & McDonald Islands! Learn about the flag of Heard & McDonald Islands!","gu":"હર્ડ અને મેકડોનાલ્ડ આઇલેન્ડ્સ! હર્ડ અને મેકડોનાલ્ડ આઇલેન્ડ્સ દેશના ધ્વજ વિશે જાણો!","hi":"हर्ड द्वीप और मैकडोनॉल्ड द्वीपसमूह! हर्ड द्वीप और मैकडोनॉल्ड द्वीपसमूह के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Heard & McDonald Islands. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ હર્ડ અને મેકડોનાલ્ડ આઇલેન્ડ્સ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह हर्ड द्वीप और मैकडोनॉल्ड द्वीपसमूह का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Heard & McDonald Islands is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? હર્ડ અને મેકડોનાલ્ડ આઇલેન્ડ્સ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? हर्ड द्वीप और मैकडोनॉल्ड द्वीपसमूह का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
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

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'hn',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Honduras","gu":"હોન્ડુરસ","hi":"होंडूरास"}'::jsonb,
  'assets/svgs/flags/hn.svg',
  '{"en":"Honduras! Learn about the flag of Honduras!","gu":"હોન્ડુરસ! હોન્ડુરસ દેશના ધ્વજ વિશે જાણો!","hi":"होंडूरास! होंडूरास के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Honduras. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ હોન્ડુરસ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह होंडूरास का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Honduras is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? હોન્ડુરસ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? होंडूरास का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  101
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'hk',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Hong Kong SAR China","gu":"હોંગકોંગ SAR ચીન","hi":"हाँग काँग"}'::jsonb,
  'assets/svgs/flags/hk.svg',
  '{"en":"Hong Kong SAR China! Learn about the flag of Hong Kong SAR China!","gu":"હોંગકોંગ SAR ચીન! હોંગકોંગ SAR ચીન દેશના ધ્વજ વિશે જાણો!","hi":"हाँग काँग! हाँग काँग के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Hong Kong SAR China. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ હોંગકોંગ SAR ચીન દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह हाँग काँग का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Hong Kong SAR China is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? હોંગકોંગ SAR ચીન નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? हाँग काँग का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  102
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'hu',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Hungary","gu":"હંગેરી","hi":"हंगरी"}'::jsonb,
  'assets/svgs/flags/hu.svg',
  '{"en":"Hungary! Learn about the flag of Hungary!","gu":"હંગેરી! હંગેરી દેશના ધ્વજ વિશે જાણો!","hi":"हंगरी! हंगरी के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Hungary. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ હંગેરી દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह हंगरी का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Hungary is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? હંગેરી નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? हंगरी का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  103
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'is',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Iceland","gu":"આઇસલેન્ડ","hi":"आइसलैंड"}'::jsonb,
  'assets/svgs/flags/is.svg',
  '{"en":"Iceland! Learn about the flag of Iceland!","gu":"આઇસલેન્ડ! આઇસલેન્ડ દેશના ધ્વજ વિશે જાણો!","hi":"आइसलैंड! आइसलैंड के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Iceland. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ આઇસલેન્ડ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह आइसलैंड का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Iceland is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? આઇસલેન્ડ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? आइसलैंड का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  104
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'in',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"India","gu":"ભારત","hi":"भारत"}'::jsonb,
  'assets/svgs/flags/in.svg',
  '{"en":"India! Learn about the flag of India!","gu":"ભારત! ભારત દેશના ધ્વજ વિશે જાણો!","hi":"भारत! भारत के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of India. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ભારત દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह भारत का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of India is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ભારત નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? भारत का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  105
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'id',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Indonesia","gu":"ઇન્ડોનેશિયા","hi":"इंडोनेशिया"}'::jsonb,
  'assets/svgs/flags/id.svg',
  '{"en":"Indonesia! Learn about the flag of Indonesia!","gu":"ઇન્ડોનેશિયા! ઇન્ડોનેશિયા દેશના ધ્વજ વિશે જાણો!","hi":"इंडोनेशिया! इंडोनेशिया के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Indonesia. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ઇન્ડોનેશિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह इंडोनेशिया का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Indonesia is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ઇન્ડોનેશિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? इंडोनेशिया का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  106
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ir',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Iran","gu":"ઈરાન","hi":"ईरान"}'::jsonb,
  'assets/svgs/flags/ir.svg',
  '{"en":"Iran! Learn about the flag of Iran!","gu":"ઈરાન! ઈરાન દેશના ધ્વજ વિશે જાણો!","hi":"ईरान! ईरान के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Iran. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ઈરાન દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह ईरान का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Iran is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ઈરાન નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? ईरान का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  107
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'iq',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Iraq","gu":"ઇરાક","hi":"इराक"}'::jsonb,
  'assets/svgs/flags/iq.svg',
  '{"en":"Iraq! Learn about the flag of Iraq!","gu":"ઇરાક! ઇરાક દેશના ધ્વજ વિશે જાણો!","hi":"इराक! इराक के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Iraq. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ઇરાક દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह इराक का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Iraq is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ઇરાક નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? इराक का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  108
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ie',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Ireland","gu":"આયર્લેન્ડ","hi":"आयरलैंड"}'::jsonb,
  'assets/svgs/flags/ie.svg',
  '{"en":"Ireland! Learn about the flag of Ireland!","gu":"આયર્લેન્ડ! આયર્લેન્ડ દેશના ધ્વજ વિશે જાણો!","hi":"आयरलैंड! आयरलैंड के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Ireland. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ આયર્લેન્ડ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह आयरलैंड का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Ireland is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? આયર્લેન્ડ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? आयरलैंड का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  109
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'im',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Isle of Man","gu":"આઇલ ઑફ મેન","hi":"आइल ऑफ़ मैन"}'::jsonb,
  'assets/svgs/flags/im.svg',
  '{"en":"Isle of Man! Learn about the flag of Isle of Man!","gu":"આઇલ ઑફ મેન! આઇલ ઑફ મેન દેશના ધ્વજ વિશે જાણો!","hi":"आइल ऑफ़ मैन! आइल ऑफ़ मैन के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Isle of Man. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ આઇલ ઑફ મેન દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह आइल ऑफ़ मैन का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Isle of Man is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? આઇલ ઑફ મેન નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? आइल ऑफ़ मैन का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  110
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'il',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Israel","gu":"ઇઝરાઇલ","hi":"इज़राइल"}'::jsonb,
  'assets/svgs/flags/il.svg',
  '{"en":"Israel! Learn about the flag of Israel!","gu":"ઇઝરાઇલ! ઇઝરાઇલ દેશના ધ્વજ વિશે જાણો!","hi":"इज़राइल! इज़राइल के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Israel. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ઇઝરાઇલ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह इज़राइल का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Israel is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ઇઝરાઇલ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? इज़राइल का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  111
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'it',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Italy","gu":"ઇટાલી","hi":"इटली"}'::jsonb,
  'assets/svgs/flags/it.svg',
  '{"en":"Italy! Learn about the flag of Italy!","gu":"ઇટાલી! ઇટાલી દેશના ધ્વજ વિશે જાણો!","hi":"इटली! इटली के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Italy. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ઇટાલી દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह इटली का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Italy is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ઇટાલી નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? इटली का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  112
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'jm',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Jamaica","gu":"જમૈકા","hi":"जमैका"}'::jsonb,
  'assets/svgs/flags/jm.svg',
  '{"en":"Jamaica! Learn about the flag of Jamaica!","gu":"જમૈકા! જમૈકા દેશના ધ્વજ વિશે જાણો!","hi":"जमैका! जमैका के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Jamaica. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ જમૈકા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह जमैका का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Jamaica is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? જમૈકા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? जमैका का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  113
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'jp',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Japan","gu":"જાપાન","hi":"जापान"}'::jsonb,
  'assets/svgs/flags/jp.svg',
  '{"en":"Japan! Learn about the flag of Japan!","gu":"જાપાન! જાપાન દેશના ધ્વજ વિશે જાણો!","hi":"जापान! जापान के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Japan. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ જાપાન દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह जापान का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Japan is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? જાપાન નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? जापान का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  114
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'je',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Jersey","gu":"જર્સી","hi":"जर्सी"}'::jsonb,
  'assets/svgs/flags/je.svg',
  '{"en":"Jersey! Learn about the flag of Jersey!","gu":"જર્સી! જર્સી દેશના ધ્વજ વિશે જાણો!","hi":"जर्सी! जर्सी के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Jersey. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ જર્સી દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह जर्सी का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Jersey is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? જર્સી નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? जर्सी का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  115
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'jo',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Jordan","gu":"જોર્ડન","hi":"जॉर्डन"}'::jsonb,
  'assets/svgs/flags/jo.svg',
  '{"en":"Jordan! Learn about the flag of Jordan!","gu":"જોર્ડન! જોર્ડન દેશના ધ્વજ વિશે જાણો!","hi":"जॉर्डन! जॉर्डन के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Jordan. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ જોર્ડન દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह जॉर्डन का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Jordan is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? જોર્ડન નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? जॉर्डन का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  116
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'kz',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Kazakhstan","gu":"કઝાકિસ્તાન","hi":"कज़ाखस्तान"}'::jsonb,
  'assets/svgs/flags/kz.svg',
  '{"en":"Kazakhstan! Learn about the flag of Kazakhstan!","gu":"કઝાકિસ્તાન! કઝાકિસ્તાન દેશના ધ્વજ વિશે જાણો!","hi":"कज़ाखस्तान! कज़ाखस्तान के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Kazakhstan. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ કઝાકિસ્તાન દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह कज़ाखस्तान का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Kazakhstan is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? કઝાકિસ્તાન નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? कज़ाखस्तान का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  117
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ke',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Kenya","gu":"કેન્યા","hi":"केन्या"}'::jsonb,
  'assets/svgs/flags/ke.svg',
  '{"en":"Kenya! Learn about the flag of Kenya!","gu":"કેન્યા! કેન્યા દેશના ધ્વજ વિશે જાણો!","hi":"केन्या! केन्या के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Kenya. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ કેન્યા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह केन्या का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Kenya is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? કેન્યા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? केन्या का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  118
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ki',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Kiribati","gu":"કિરિબાટી","hi":"किरिबाती"}'::jsonb,
  'assets/svgs/flags/ki.svg',
  '{"en":"Kiribati! Learn about the flag of Kiribati!","gu":"કિરિબાટી! કિરિબાટી દેશના ધ્વજ વિશે જાણો!","hi":"किरिबाती! किरिबाती के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Kiribati. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ કિરિબાટી દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह किरिबाती का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Kiribati is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? કિરિબાટી નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? किरिबाती का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  119
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'kw',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Kuwait","gu":"કુવૈત","hi":"कुवैत"}'::jsonb,
  'assets/svgs/flags/kw.svg',
  '{"en":"Kuwait! Learn about the flag of Kuwait!","gu":"કુવૈત! કુવૈત દેશના ધ્વજ વિશે જાણો!","hi":"कुवैत! कुवैत के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Kuwait. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ કુવૈત દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह कुवैत का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Kuwait is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? કુવૈત નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? कुवैत का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  120
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'kg',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Kyrgyzstan","gu":"કિર્ગિઝ્સ્તાન","hi":"किर्गिज़स्तान"}'::jsonb,
  'assets/svgs/flags/kg.svg',
  '{"en":"Kyrgyzstan! Learn about the flag of Kyrgyzstan!","gu":"કિર્ગિઝ્સ્તાન! કિર્ગિઝ્સ્તાન દેશના ધ્વજ વિશે જાણો!","hi":"किर्गिज़स्तान! किर्गिज़स्तान के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Kyrgyzstan. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ કિર્ગિઝ્સ્તાન દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह किर्गिज़स्तान का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Kyrgyzstan is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? કિર્ગિઝ્સ્તાન નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? किर्गिज़स्तान का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  121
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'la',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Laos","gu":"લાઓસ","hi":"लाओस"}'::jsonb,
  'assets/svgs/flags/la.svg',
  '{"en":"Laos! Learn about the flag of Laos!","gu":"લાઓસ! લાઓસ દેશના ધ્વજ વિશે જાણો!","hi":"लाओस! लाओस के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Laos. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ લાઓસ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह लाओस का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Laos is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? લાઓસ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? लाओस का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  122
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'lv',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Latvia","gu":"લાત્વિયા","hi":"लातविया"}'::jsonb,
  'assets/svgs/flags/lv.svg',
  '{"en":"Latvia! Learn about the flag of Latvia!","gu":"લાત્વિયા! લાત્વિયા દેશના ધ્વજ વિશે જાણો!","hi":"लातविया! लातविया के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Latvia. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ લાત્વિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह लातविया का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Latvia is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? લાત્વિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? लातविया का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  123
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'lb',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Lebanon","gu":"લેબનોન","hi":"लेबनान"}'::jsonb,
  'assets/svgs/flags/lb.svg',
  '{"en":"Lebanon! Learn about the flag of Lebanon!","gu":"લેબનોન! લેબનોન દેશના ધ્વજ વિશે જાણો!","hi":"लेबनान! लेबनान के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Lebanon. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ લેબનોન દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह लेबनान का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Lebanon is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? લેબનોન નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? लेबनान का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  124
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ls',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Lesotho","gu":"લેસોથો","hi":"लेसोथो"}'::jsonb,
  'assets/svgs/flags/ls.svg',
  '{"en":"Lesotho! Learn about the flag of Lesotho!","gu":"લેસોથો! લેસોથો દેશના ધ્વજ વિશે જાણો!","hi":"लेसोथो! लेसोथो के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Lesotho. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ લેસોથો દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह लेसोथो का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Lesotho is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? લેસોથો નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? लेसोथो का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  125
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'lr',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Liberia","gu":"લાઇબેરિયા","hi":"लाइबेरिया"}'::jsonb,
  'assets/svgs/flags/lr.svg',
  '{"en":"Liberia! Learn about the flag of Liberia!","gu":"લાઇબેરિયા! લાઇબેરિયા દેશના ધ્વજ વિશે જાણો!","hi":"लाइबेरिया! लाइबेरिया के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Liberia. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ લાઇબેરિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह लाइबेरिया का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Liberia is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? લાઇબેરિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? लाइबेरिया का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  126
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ly',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Libya","gu":"લિબિયા","hi":"लीबिया"}'::jsonb,
  'assets/svgs/flags/ly.svg',
  '{"en":"Libya! Learn about the flag of Libya!","gu":"લિબિયા! લિબિયા દેશના ધ્વજ વિશે જાણો!","hi":"लीबिया! लीबिया के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Libya. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ લિબિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह लीबिया का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Libya is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? લિબિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? लीबिया का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  127
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'li',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Liechtenstein","gu":"લૈચટેંસ્ટેઇન","hi":"लिचेंस्टीन"}'::jsonb,
  'assets/svgs/flags/li.svg',
  '{"en":"Liechtenstein! Learn about the flag of Liechtenstein!","gu":"લૈચટેંસ્ટેઇન! લૈચટેંસ્ટેઇન દેશના ધ્વજ વિશે જાણો!","hi":"लिचेंस्टीन! लिचेंस्टीन के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Liechtenstein. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ લૈચટેંસ્ટેઇન દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह लिचेंस्टीन का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Liechtenstein is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? લૈચટેંસ્ટેઇન નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? लिचेंस्टीन का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  128
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'lt',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Lithuania","gu":"લિથુઆનિયા","hi":"लिथुआनिया"}'::jsonb,
  'assets/svgs/flags/lt.svg',
  '{"en":"Lithuania! Learn about the flag of Lithuania!","gu":"લિથુઆનિયા! લિથુઆનિયા દેશના ધ્વજ વિશે જાણો!","hi":"लिथुआनिया! लिथुआनिया के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Lithuania. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ લિથુઆનિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह लिथुआनिया का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Lithuania is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? લિથુઆનિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? लिथुआनिया का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  129
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'lu',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Luxembourg","gu":"લક્ઝમબર્ગ","hi":"लग्ज़मबर्ग"}'::jsonb,
  'assets/svgs/flags/lu.svg',
  '{"en":"Luxembourg! Learn about the flag of Luxembourg!","gu":"લક્ઝમબર્ગ! લક્ઝમબર્ગ દેશના ધ્વજ વિશે જાણો!","hi":"लग्ज़मबर्ग! लग्ज़मबर्ग के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Luxembourg. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ લક્ઝમબર્ગ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह लग्ज़मबर्ग का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Luxembourg is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? લક્ઝમબર્ગ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? लग्ज़मबर्ग का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  130
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'mo',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Macao SAR China","gu":"મકાઉ SAR ચીન","hi":"मकाऊ"}'::jsonb,
  'assets/svgs/flags/mo.svg',
  '{"en":"Macao SAR China! Learn about the flag of Macao SAR China!","gu":"મકાઉ SAR ચીન! મકાઉ SAR ચીન દેશના ધ્વજ વિશે જાણો!","hi":"मकाऊ! मकाऊ के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Macao SAR China. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ મકાઉ SAR ચીન દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह मकाऊ का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Macao SAR China is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? મકાઉ SAR ચીન નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? मकाऊ का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  131
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'mg',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Madagascar","gu":"મેડાગાસ્કર","hi":"मेडागास्कर"}'::jsonb,
  'assets/svgs/flags/mg.svg',
  '{"en":"Madagascar! Learn about the flag of Madagascar!","gu":"મેડાગાસ્કર! મેડાગાસ્કર દેશના ધ્વજ વિશે જાણો!","hi":"मेडागास्कर! मेडागास्कर के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Madagascar. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ મેડાગાસ્કર દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह मेडागास्कर का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Madagascar is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? મેડાગાસ્કર નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? मेडागास्कर का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  132
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'mw',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Malawi","gu":"માલાવી","hi":"मलावी"}'::jsonb,
  'assets/svgs/flags/mw.svg',
  '{"en":"Malawi! Learn about the flag of Malawi!","gu":"માલાવી! માલાવી દેશના ધ્વજ વિશે જાણો!","hi":"मलावी! मलावी के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Malawi. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ માલાવી દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह मलावी का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Malawi is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? માલાવી નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? मलावी का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  133
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'my',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Malaysia","gu":"મલેશિયા","hi":"मलेशिया"}'::jsonb,
  'assets/svgs/flags/my.svg',
  '{"en":"Malaysia! Learn about the flag of Malaysia!","gu":"મલેશિયા! મલેશિયા દેશના ધ્વજ વિશે જાણો!","hi":"मलेशिया! मलेशिया के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Malaysia. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ મલેશિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह मलेशिया का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Malaysia is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? મલેશિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? मलेशिया का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  134
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'mv',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Maldives","gu":"માલદિવ્સ","hi":"मालदीव"}'::jsonb,
  'assets/svgs/flags/mv.svg',
  '{"en":"Maldives! Learn about the flag of Maldives!","gu":"માલદિવ્સ! માલદિવ્સ દેશના ધ્વજ વિશે જાણો!","hi":"मालदीव! मालदीव के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Maldives. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ માલદિવ્સ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह मालदीव का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Maldives is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? માલદિવ્સ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? मालदीव का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  135
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ml',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Mali","gu":"માલી","hi":"माली"}'::jsonb,
  'assets/svgs/flags/ml.svg',
  '{"en":"Mali! Learn about the flag of Mali!","gu":"માલી! માલી દેશના ધ્વજ વિશે જાણો!","hi":"माली! माली के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Mali. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ માલી દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह माली का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Mali is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? માલી નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? माली का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  136
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'mt',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Malta","gu":"માલ્ટા","hi":"माल्टा"}'::jsonb,
  'assets/svgs/flags/mt.svg',
  '{"en":"Malta! Learn about the flag of Malta!","gu":"માલ્ટા! માલ્ટા દેશના ધ્વજ વિશે જાણો!","hi":"माल्टा! माल्टा के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Malta. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ માલ્ટા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह माल्टा का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Malta is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? માલ્ટા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? माल्टा का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  137
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'mh',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Marshall Islands","gu":"માર્શલ આઇલેન્ડ્સ","hi":"मार्शल द्वीपसमूह"}'::jsonb,
  'assets/svgs/flags/mh.svg',
  '{"en":"Marshall Islands! Learn about the flag of Marshall Islands!","gu":"માર્શલ આઇલેન્ડ્સ! માર્શલ આઇલેન્ડ્સ દેશના ધ્વજ વિશે જાણો!","hi":"मार्शल द्वीपसमूह! मार्शल द्वीपसमूह के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Marshall Islands. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ માર્શલ આઇલેન્ડ્સ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह मार्शल द्वीपसमूह का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Marshall Islands is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? માર્શલ આઇલેન્ડ્સ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? मार्शल द्वीपसमूह का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  138
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'mq',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Martinique","gu":"માર્ટીનીક","hi":"मार्टीनिक"}'::jsonb,
  'assets/svgs/flags/mq.svg',
  '{"en":"Martinique! Learn about the flag of Martinique!","gu":"માર્ટીનીક! માર્ટીનીક દેશના ધ્વજ વિશે જાણો!","hi":"मार्टीनिक! मार्टीनिक के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Martinique. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ માર્ટીનીક દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह मार्टीनिक का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Martinique is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? માર્ટીનીક નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? मार्टीनिक का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  139
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'mr',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Mauritania","gu":"મૌરિટાનિયા","hi":"मॉरिटानिया"}'::jsonb,
  'assets/svgs/flags/mr.svg',
  '{"en":"Mauritania! Learn about the flag of Mauritania!","gu":"મૌરિટાનિયા! મૌરિટાનિયા દેશના ધ્વજ વિશે જાણો!","hi":"मॉरिटानिया! मॉरिटानिया के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Mauritania. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ મૌરિટાનિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह मॉरिटानिया का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Mauritania is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? મૌરિટાનિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? मॉरिटानिया का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  140
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'mu',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Mauritius","gu":"મોરિશિયસ","hi":"मॉरीशस"}'::jsonb,
  'assets/svgs/flags/mu.svg',
  '{"en":"Mauritius! Learn about the flag of Mauritius!","gu":"મોરિશિયસ! મોરિશિયસ દેશના ધ્વજ વિશે જાણો!","hi":"मॉरीशस! मॉरीशस के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Mauritius. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ મોરિશિયસ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह मॉरीशस का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Mauritius is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? મોરિશિયસ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? मॉरीशस का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  141
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'yt',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Mayotte","gu":"મેયોટ","hi":"मायोते"}'::jsonb,
  'assets/svgs/flags/yt.svg',
  '{"en":"Mayotte! Learn about the flag of Mayotte!","gu":"મેયોટ! મેયોટ દેશના ધ્વજ વિશે જાણો!","hi":"मायोते! मायोते के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Mayotte. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ મેયોટ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह मायोते का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Mayotte is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? મેયોટ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? मायोते का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  142
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'mx',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Mexico","gu":"મેક્સિકો","hi":"मैक्सिको"}'::jsonb,
  'assets/svgs/flags/mx.svg',
  '{"en":"Mexico! Learn about the flag of Mexico!","gu":"મેક્સિકો! મેક્સિકો દેશના ધ્વજ વિશે જાણો!","hi":"मैक्सिको! मैक्सिको के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Mexico. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ મેક્સિકો દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह मैक्सिको का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Mexico is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? મેક્સિકો નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? मैक्सिको का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  143
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'fm',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Micronesia","gu":"માઇક્રોનેશિયા","hi":"माइक्रोनेशिया"}'::jsonb,
  'assets/svgs/flags/fm.svg',
  '{"en":"Micronesia! Learn about the flag of Micronesia!","gu":"માઇક્રોનેશિયા! માઇક્રોનેશિયા દેશના ધ્વજ વિશે જાણો!","hi":"माइक्रोनेशिया! माइक्रोनेशिया के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Micronesia. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ માઇક્રોનેશિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह माइक्रोनेशिया का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Micronesia is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? માઇક્રોનેશિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? माइक्रोनेशिया का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  144
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'md',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Moldova","gu":"મોલડોવા","hi":"मॉल्डोवा"}'::jsonb,
  'assets/svgs/flags/md.svg',
  '{"en":"Moldova! Learn about the flag of Moldova!","gu":"મોલડોવા! મોલડોવા દેશના ધ્વજ વિશે જાણો!","hi":"मॉल्डोवा! मॉल्डोवा के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Moldova. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ મોલડોવા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह मॉल्डोवा का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Moldova is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? મોલડોવા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? मॉल्डोवा का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  145
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'mc',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Monaco","gu":"મોનાકો","hi":"मोनाको"}'::jsonb,
  'assets/svgs/flags/mc.svg',
  '{"en":"Monaco! Learn about the flag of Monaco!","gu":"મોનાકો! મોનાકો દેશના ધ્વજ વિશે જાણો!","hi":"मोनाको! मोनाको के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Monaco. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ મોનાકો દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह मोनाको का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Monaco is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? મોનાકો નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? मोनाको का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  146
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'mn',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Mongolia","gu":"મંગોલિયા","hi":"मंगोलिया"}'::jsonb,
  'assets/svgs/flags/mn.svg',
  '{"en":"Mongolia! Learn about the flag of Mongolia!","gu":"મંગોલિયા! મંગોલિયા દેશના ધ્વજ વિશે જાણો!","hi":"मंगोलिया! मंगोलिया के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Mongolia. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ મંગોલિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह मंगोलिया का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Mongolia is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? મંગોલિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? मंगोलिया का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  147
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'me',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Montenegro","gu":"મૉન્ટેનેગ્રો","hi":"मोंटेनेग्रो"}'::jsonb,
  'assets/svgs/flags/me.svg',
  '{"en":"Montenegro! Learn about the flag of Montenegro!","gu":"મૉન્ટેનેગ્રો! મૉન્ટેનેગ્રો દેશના ધ્વજ વિશે જાણો!","hi":"मोंटेनेग्रो! मोंटेनेग्रो के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Montenegro. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ મૉન્ટેનેગ્રો દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह मोंटेनेग्रो का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Montenegro is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? મૉન્ટેનેગ્રો નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? मोंटेनेग्रो का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  148
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ms',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Montserrat","gu":"મોંટસેરાત","hi":"मोंटसेरात"}'::jsonb,
  'assets/svgs/flags/ms.svg',
  '{"en":"Montserrat! Learn about the flag of Montserrat!","gu":"મોંટસેરાત! મોંટસેરાત દેશના ધ્વજ વિશે જાણો!","hi":"मोंटसेरात! मोंटसेरात के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Montserrat. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ મોંટસેરાત દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह मोंटसेरात का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Montserrat is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? મોંટસેરાત નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? मोंटसेरात का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  149
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ma',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Morocco","gu":"મોરોક્કો","hi":"मोरक्को"}'::jsonb,
  'assets/svgs/flags/ma.svg',
  '{"en":"Morocco! Learn about the flag of Morocco!","gu":"મોરોક્કો! મોરોક્કો દેશના ધ્વજ વિશે જાણો!","hi":"मोरक्को! मोरक्को के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Morocco. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ મોરોક્કો દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह मोरक्को का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Morocco is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? મોરોક્કો નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? मोरक्को का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  150
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'mz',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Mozambique","gu":"મોઝામ્બિક","hi":"मोज़ांबिक"}'::jsonb,
  'assets/svgs/flags/mz.svg',
  '{"en":"Mozambique! Learn about the flag of Mozambique!","gu":"મોઝામ્બિક! મોઝામ્બિક દેશના ધ્વજ વિશે જાણો!","hi":"मोज़ांबिक! मोज़ांबिक के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Mozambique. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ મોઝામ્બિક દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह मोज़ांबिक का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Mozambique is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? મોઝામ્બિક નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? मोज़ांबिक का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  151
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'mm',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Myanmar","gu":"મ્યાંમાર","hi":"म्यांमार"}'::jsonb,
  'assets/svgs/flags/mm.svg',
  '{"en":"Myanmar! Learn about the flag of Myanmar!","gu":"મ્યાંમાર! મ્યાંમાર દેશના ધ્વજ વિશે જાણો!","hi":"म्यांमार! म्यांमार के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Myanmar. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ મ્યાંમાર દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह म्यांमार का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Myanmar is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? મ્યાંમાર નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? म्यांमार का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  152
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'na',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Namibia","gu":"નામિબિયા","hi":"नामीबिया"}'::jsonb,
  'assets/svgs/flags/na.svg',
  '{"en":"Namibia! Learn about the flag of Namibia!","gu":"નામિબિયા! નામિબિયા દેશના ધ્વજ વિશે જાણો!","hi":"नामीबिया! नामीबिया के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Namibia. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ નામિબિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह नामीबिया का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Namibia is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? નામિબિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? नामीबिया का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  153
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'nr',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Nauru","gu":"નૌરુ","hi":"नाउरु"}'::jsonb,
  'assets/svgs/flags/nr.svg',
  '{"en":"Nauru! Learn about the flag of Nauru!","gu":"નૌરુ! નૌરુ દેશના ધ્વજ વિશે જાણો!","hi":"नाउरु! नाउरु के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Nauru. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ નૌરુ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह नाउरु का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Nauru is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? નૌરુ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? नाउरु का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  154
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'np',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Nepal","gu":"નેપાળ","hi":"नेपाल"}'::jsonb,
  'assets/svgs/flags/np.svg',
  '{"en":"Nepal! Learn about the flag of Nepal!","gu":"નેપાળ! નેપાળ દેશના ધ્વજ વિશે જાણો!","hi":"नेपाल! नेपाल के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Nepal. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ નેપાળ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह नेपाल का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Nepal is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? નેપાળ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? नेपाल का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  155
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'nl',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Netherlands","gu":"નેધરલેન્ડ્સ","hi":"नीदरलैंड"}'::jsonb,
  'assets/svgs/flags/nl.svg',
  '{"en":"Netherlands! Learn about the flag of Netherlands!","gu":"નેધરલેન્ડ્સ! નેધરલેન્ડ્સ દેશના ધ્વજ વિશે જાણો!","hi":"नीदरलैंड! नीदरलैंड के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Netherlands. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ નેધરલેન્ડ્સ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह नीदरलैंड का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Netherlands is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? નેધરલેન્ડ્સ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? नीदरलैंड का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  156
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'nc',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"New Caledonia","gu":"ન્યુ સેલેડોનિયા","hi":"न्यू कैलेडोनिया"}'::jsonb,
  'assets/svgs/flags/nc.svg',
  '{"en":"New Caledonia! Learn about the flag of New Caledonia!","gu":"ન્યુ સેલેડોનિયા! ન્યુ સેલેડોનિયા દેશના ધ્વજ વિશે જાણો!","hi":"न्यू कैलेडोनिया! न्यू कैलेडोनिया के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of New Caledonia. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ન્યુ સેલેડોનિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह न्यू कैलेडोनिया का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of New Caledonia is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ન્યુ સેલેડોનિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? न्यू कैलेडोनिया का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  157
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'nz',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"New Zealand","gu":"ન્યુઝીલેન્ડ","hi":"न्यूज़ीलैंड"}'::jsonb,
  'assets/svgs/flags/nz.svg',
  '{"en":"New Zealand! Learn about the flag of New Zealand!","gu":"ન્યુઝીલેન્ડ! ન્યુઝીલેન્ડ દેશના ધ્વજ વિશે જાણો!","hi":"न्यूज़ीलैंड! न्यूज़ीलैंड के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of New Zealand. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ન્યુઝીલેન્ડ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह न्यूज़ीलैंड का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of New Zealand is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ન્યુઝીલેન્ડ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? न्यूज़ीलैंड का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  158
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ni',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Nicaragua","gu":"નિકારાગુઆ","hi":"निकारागुआ"}'::jsonb,
  'assets/svgs/flags/ni.svg',
  '{"en":"Nicaragua! Learn about the flag of Nicaragua!","gu":"નિકારાગુઆ! નિકારાગુઆ દેશના ધ્વજ વિશે જાણો!","hi":"निकारागुआ! निकारागुआ के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Nicaragua. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ નિકારાગુઆ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह निकारागुआ का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Nicaragua is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? નિકારાગુઆ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? निकारागुआ का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  159
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ne',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Niger","gu":"નાઇજર","hi":"नाइजर"}'::jsonb,
  'assets/svgs/flags/ne.svg',
  '{"en":"Niger! Learn about the flag of Niger!","gu":"નાઇજર! નાઇજર દેશના ધ્વજ વિશે જાણો!","hi":"नाइजर! नाइजर के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Niger. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ નાઇજર દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह नाइजर का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Niger is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? નાઇજર નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? नाइजर का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  160
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ng',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Nigeria","gu":"નાઇજેરિયા","hi":"नाइजीरिया"}'::jsonb,
  'assets/svgs/flags/ng.svg',
  '{"en":"Nigeria! Learn about the flag of Nigeria!","gu":"નાઇજેરિયા! નાઇજેરિયા દેશના ધ્વજ વિશે જાણો!","hi":"नाइजीरिया! नाइजीरिया के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Nigeria. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ નાઇજેરિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह नाइजीरिया का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Nigeria is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? નાઇજેરિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? नाइजीरिया का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  161
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'nu',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Niue","gu":"નીયુ","hi":"नीयू"}'::jsonb,
  'assets/svgs/flags/nu.svg',
  '{"en":"Niue! Learn about the flag of Niue!","gu":"નીયુ! નીયુ દેશના ધ્વજ વિશે જાણો!","hi":"नीयू! नीयू के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Niue. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ નીયુ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह नीयू का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Niue is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? નીયુ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? नीयू का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  162
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'nf',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Norfolk Island","gu":"નોરફોક આઇલેન્ડ્સ","hi":"नॉरफ़ॉक द्वीप"}'::jsonb,
  'assets/svgs/flags/nf.svg',
  '{"en":"Norfolk Island! Learn about the flag of Norfolk Island!","gu":"નોરફોક આઇલેન્ડ્સ! નોરફોક આઇલેન્ડ્સ દેશના ધ્વજ વિશે જાણો!","hi":"नॉरफ़ॉक द्वीप! नॉरफ़ॉक द्वीप के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Norfolk Island. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ નોરફોક આઇલેન્ડ્સ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह नॉरफ़ॉक द्वीप का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Norfolk Island is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? નોરફોક આઇલેન્ડ્સ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? नॉरफ़ॉक द्वीप का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  163
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'kp',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"North Korea","gu":"ઉત્તર કોરિયા","hi":"उत्तर कोरिया"}'::jsonb,
  'assets/svgs/flags/kp.svg',
  '{"en":"North Korea! Learn about the flag of North Korea!","gu":"ઉત્તર કોરિયા! ઉત્તર કોરિયા દેશના ધ્વજ વિશે જાણો!","hi":"उत्तर कोरिया! उत्तर कोरिया के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of North Korea. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ઉત્તર કોરિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह उत्तर कोरिया का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of North Korea is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ઉત્તર કોરિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? उत्तर कोरिया का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  164
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'mk',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"North Macedonia","gu":"ઉત્તર મેસેડોનિયા","hi":"उत्तरी मकदूनिया"}'::jsonb,
  'assets/svgs/flags/mk.svg',
  '{"en":"North Macedonia! Learn about the flag of North Macedonia!","gu":"ઉત્તર મેસેડોનિયા! ઉત્તર મેસેડોનિયા દેશના ધ્વજ વિશે જાણો!","hi":"उत्तरी मकदूनिया! उत्तरी मकदूनिया के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of North Macedonia. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ઉત્તર મેસેડોનિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह उत्तरी मकदूनिया का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of North Macedonia is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ઉત્તર મેસેડોનિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? उत्तरी मकदूनिया का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  165
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'gb-nir',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Northern Ireland","gu":"ઉત્તરી આયર્લેન્ડ","hi":"उत्तरी आयरलैंड"}'::jsonb,
  'assets/svgs/flags/gb-nir.svg',
  '{"en":"Northern Ireland! Learn about the flag of Northern Ireland!","gu":"ઉત્તરી આયર્લેન્ડ! ઉત્તરી આયર્લેન્ડ દેશના ધ્વજ વિશે જાણો!","hi":"उत्तरी आयरलैंड! उत्तरी आयरलैंड के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Northern Ireland. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ઉત્તરી આયર્લેન્ડ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह उत्तरी आयरलैंड का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Northern Ireland is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ઉત્તરી આયર્લેન્ડ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? उत्तरी आयरलैंड का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  166
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'mp',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Northern Mariana Islands","gu":"ઉત્તરી મારિયાના આઇલેન્ડ્સ","hi":"उत्तरी मारियाना द्वीपसमूह"}'::jsonb,
  'assets/svgs/flags/mp.svg',
  '{"en":"Northern Mariana Islands! Learn about the flag of Northern Mariana Islands!","gu":"ઉત્તરી મારિયાના આઇલેન્ડ્સ! ઉત્તરી મારિયાના આઇલેન્ડ્સ દેશના ધ્વજ વિશે જાણો!","hi":"उत्तरी मारियाना द्वीपसमूह! उत्तरी मारियाना द्वीपसमूह के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Northern Mariana Islands. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ઉત્તરી મારિયાના આઇલેન્ડ્સ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह उत्तरी मारियाना द्वीपसमूह का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Northern Mariana Islands is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ઉત્તરી મારિયાના આઇલેન્ડ્સ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? उत्तरी मारियाना द्वीपसमूह का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  167
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'no',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Norway","gu":"નૉર્વે","hi":"नॉर्वे"}'::jsonb,
  'assets/svgs/flags/no.svg',
  '{"en":"Norway! Learn about the flag of Norway!","gu":"નૉર્વે! નૉર્વે દેશના ધ્વજ વિશે જાણો!","hi":"नॉर्वे! नॉर्वे के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Norway. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ નૉર્વે દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह नॉर्वे का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Norway is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? નૉર્વે નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? नॉर्वे का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  168
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'om',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Oman","gu":"ઓમાન","hi":"ओमान"}'::jsonb,
  'assets/svgs/flags/om.svg',
  '{"en":"Oman! Learn about the flag of Oman!","gu":"ઓમાન! ઓમાન દેશના ધ્વજ વિશે જાણો!","hi":"ओमान! ओमान के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Oman. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ઓમાન દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह ओमान का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Oman is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ઓમાન નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? ओमान का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  169
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'pk',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Pakistan","gu":"પાકિસ્તાન","hi":"पाकिस्तान"}'::jsonb,
  'assets/svgs/flags/pk.svg',
  '{"en":"Pakistan! Learn about the flag of Pakistan!","gu":"પાકિસ્તાન! પાકિસ્તાન દેશના ધ્વજ વિશે જાણો!","hi":"पाकिस्तान! पाकिस्तान के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Pakistan. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ પાકિસ્તાન દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह पाकिस्तान का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Pakistan is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? પાકિસ્તાન નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? पाकिस्तान का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  170
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'pw',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Palau","gu":"પલાઉ","hi":"पलाऊ"}'::jsonb,
  'assets/svgs/flags/pw.svg',
  '{"en":"Palau! Learn about the flag of Palau!","gu":"પલાઉ! પલાઉ દેશના ધ્વજ વિશે જાણો!","hi":"पलाऊ! पलाऊ के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Palau. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ પલાઉ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह पलाऊ का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Palau is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? પલાઉ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? पलाऊ का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  171
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ps',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Palestinian Territories","gu":"પેલેસ્ટિનિયન ટેરિટરી","hi":"फ़िलिस्तीनी क्षेत्र"}'::jsonb,
  'assets/svgs/flags/ps.svg',
  '{"en":"Palestinian Territories! Learn about the flag of Palestinian Territories!","gu":"પેલેસ્ટિનિયન ટેરિટરી! પેલેસ્ટિનિયન ટેરિટરી દેશના ધ્વજ વિશે જાણો!","hi":"फ़िलिस्तीनी क्षेत्र! फ़िलिस्तीनी क्षेत्र के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Palestinian Territories. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ પેલેસ્ટિનિયન ટેરિટરી દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह फ़िलिस्तीनी क्षेत्र का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Palestinian Territories is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? પેલેસ્ટિનિયન ટેરિટરી નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? फ़िलिस्तीनी क्षेत्र का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  172
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'pa',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Panama","gu":"પનામા","hi":"पनामा"}'::jsonb,
  'assets/svgs/flags/pa.svg',
  '{"en":"Panama! Learn about the flag of Panama!","gu":"પનામા! પનામા દેશના ધ્વજ વિશે જાણો!","hi":"पनामा! पनामा के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Panama. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ પનામા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह पनामा का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Panama is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? પનામા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? पनामा का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  173
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'pg',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Papua New Guinea","gu":"પાપુઆ ન્યૂ ગિની","hi":"पापुआ न्यू गिनी"}'::jsonb,
  'assets/svgs/flags/pg.svg',
  '{"en":"Papua New Guinea! Learn about the flag of Papua New Guinea!","gu":"પાપુઆ ન્યૂ ગિની! પાપુઆ ન્યૂ ગિની દેશના ધ્વજ વિશે જાણો!","hi":"पापुआ न्यू गिनी! पापुआ न्यू गिनी के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Papua New Guinea. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ પાપુઆ ન્યૂ ગિની દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह पापुआ न्यू गिनी का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Papua New Guinea is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? પાપુઆ ન્યૂ ગિની નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? पापुआ न्यू गिनी का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  174
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'py',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Paraguay","gu":"પેરાગ્વે","hi":"पराग्वे"}'::jsonb,
  'assets/svgs/flags/py.svg',
  '{"en":"Paraguay! Learn about the flag of Paraguay!","gu":"પેરાગ્વે! પેરાગ્વે દેશના ધ્વજ વિશે જાણો!","hi":"पराग्वे! पराग्वे के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Paraguay. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ પેરાગ્વે દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह पराग्वे का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Paraguay is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? પેરાગ્વે નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? पराग्वे का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  175
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'pe',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Peru","gu":"પેરુ","hi":"पेरू"}'::jsonb,
  'assets/svgs/flags/pe.svg',
  '{"en":"Peru! Learn about the flag of Peru!","gu":"પેરુ! પેરુ દેશના ધ્વજ વિશે જાણો!","hi":"पेरू! पेरू के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Peru. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ પેરુ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह पेरू का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Peru is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? પેરુ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? पेरू का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  176
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ph',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Philippines","gu":"ફિલિપિન્સ","hi":"फ़िलिपींस"}'::jsonb,
  'assets/svgs/flags/ph.svg',
  '{"en":"Philippines! Learn about the flag of Philippines!","gu":"ફિલિપિન્સ! ફિલિપિન્સ દેશના ધ્વજ વિશે જાણો!","hi":"फ़िलिपींस! फ़िलिपींस के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Philippines. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ફિલિપિન્સ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह फ़िलिपींस का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Philippines is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ફિલિપિન્સ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? फ़िलिपींस का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  177
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'pn',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Pitcairn Islands","gu":"પીટકૈર્ન આઇલેન્ડ્સ","hi":"पिटकैर्न द्वीपसमूह"}'::jsonb,
  'assets/svgs/flags/pn.svg',
  '{"en":"Pitcairn Islands! Learn about the flag of Pitcairn Islands!","gu":"પીટકૈર્ન આઇલેન્ડ્સ! પીટકૈર્ન આઇલેન્ડ્સ દેશના ધ્વજ વિશે જાણો!","hi":"पिटकैर्न द्वीपसमूह! पिटकैर्न द्वीपसमूह के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Pitcairn Islands. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ પીટકૈર્ન આઇલેન્ડ્સ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह पिटकैर्न द्वीपसमूह का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Pitcairn Islands is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? પીટકૈર્ન આઇલેન્ડ્સ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? पिटकैर्न द्वीपसमूह का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  178
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'pl',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Poland","gu":"પોલેંડ","hi":"पोलैंड"}'::jsonb,
  'assets/svgs/flags/pl.svg',
  '{"en":"Poland! Learn about the flag of Poland!","gu":"પોલેંડ! પોલેંડ દેશના ધ્વજ વિશે જાણો!","hi":"पोलैंड! पोलैंड के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Poland. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ પોલેંડ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह पोलैंड का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Poland is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? પોલેંડ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? पोलैंड का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  179
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'pt',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Portugal","gu":"પોર્ટુગલ","hi":"पुर्तगाल"}'::jsonb,
  'assets/svgs/flags/pt.svg',
  '{"en":"Portugal! Learn about the flag of Portugal!","gu":"પોર્ટુગલ! પોર્ટુગલ દેશના ધ્વજ વિશે જાણો!","hi":"पुर्तगाल! पुर्तगाल के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Portugal. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ પોર્ટુગલ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह पुर्तगाल का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Portugal is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? પોર્ટુગલ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? पुर्तगाल का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  180
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'pr',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Puerto Rico","gu":"પ્યુઅર્ટો રિકો","hi":"पोर्टो रिको"}'::jsonb,
  'assets/svgs/flags/pr.svg',
  '{"en":"Puerto Rico! Learn about the flag of Puerto Rico!","gu":"પ્યુઅર્ટો રિકો! પ્યુઅર્ટો રિકો દેશના ધ્વજ વિશે જાણો!","hi":"पोर्टो रिको! पोर्टो रिको के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Puerto Rico. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ પ્યુઅર્ટો રિકો દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह पोर्टो रिको का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Puerto Rico is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? પ્યુઅર્ટો રિકો નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? पोर्टो रिको का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  181
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'qa',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Qatar","gu":"કતાર","hi":"क़तर"}'::jsonb,
  'assets/svgs/flags/qa.svg',
  '{"en":"Qatar! Learn about the flag of Qatar!","gu":"કતાર! કતાર દેશના ધ્વજ વિશે જાણો!","hi":"क़तर! क़तर के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Qatar. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ કતાર દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह क़तर का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Qatar is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? કતાર નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? क़तर का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  182
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  're',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Réunion","gu":"રીયુનિયન","hi":"रियूनियन"}'::jsonb,
  'assets/svgs/flags/re.svg',
  '{"en":"Réunion! Learn about the flag of Réunion!","gu":"રીયુનિયન! રીયુનિયન દેશના ધ્વજ વિશે જાણો!","hi":"रियूनियन! रियूनियन के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Réunion. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ રીયુનિયન દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह रियूनियन का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Réunion is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? રીયુનિયન નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? रियूनियन का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  183
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ro',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Romania","gu":"રોમાનિયા","hi":"रोमानिया"}'::jsonb,
  'assets/svgs/flags/ro.svg',
  '{"en":"Romania! Learn about the flag of Romania!","gu":"રોમાનિયા! રોમાનિયા દેશના ધ્વજ વિશે જાણો!","hi":"रोमानिया! रोमानिया के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Romania. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ રોમાનિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह रोमानिया का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Romania is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? રોમાનિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? रोमानिया का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  184
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ru',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Russia","gu":"રશિયા","hi":"रूस"}'::jsonb,
  'assets/svgs/flags/ru.svg',
  '{"en":"Russia! Learn about the flag of Russia!","gu":"રશિયા! રશિયા દેશના ધ્વજ વિશે જાણો!","hi":"रूस! रूस के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Russia. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ રશિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह रूस का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Russia is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? રશિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? रूस का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  185
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'rw',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Rwanda","gu":"રવાંડા","hi":"रवांडा"}'::jsonb,
  'assets/svgs/flags/rw.svg',
  '{"en":"Rwanda! Learn about the flag of Rwanda!","gu":"રવાંડા! રવાંડા દેશના ધ્વજ વિશે જાણો!","hi":"रवांडा! रवांडा के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Rwanda. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ રવાંડા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह रवांडा का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Rwanda is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? રવાંડા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? रवांडा का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  186
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ws',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Samoa","gu":"સમોઆ","hi":"समोआ"}'::jsonb,
  'assets/svgs/flags/ws.svg',
  '{"en":"Samoa! Learn about the flag of Samoa!","gu":"સમોઆ! સમોઆ દેશના ધ્વજ વિશે જાણો!","hi":"समोआ! समोआ के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Samoa. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ સમોઆ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह समोआ का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Samoa is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? સમોઆ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? समोआ का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  187
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'sm',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"San Marino","gu":"સૅન મેરિનો","hi":"सैन मेरीनो"}'::jsonb,
  'assets/svgs/flags/sm.svg',
  '{"en":"San Marino! Learn about the flag of San Marino!","gu":"સૅન મેરિનો! સૅન મેરિનો દેશના ધ્વજ વિશે જાણો!","hi":"सैन मेरीनो! सैन मेरीनो के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of San Marino. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ સૅન મેરિનો દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह सैन मेरीनो का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of San Marino is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? સૅન મેરિનો નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? सैन मेरीनो का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  188
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'st',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"São Tomé & Príncipe","gu":"સાઓ ટૉમ અને પ્રિંસિપે","hi":"साओ टोम और प्रिंसिपे"}'::jsonb,
  'assets/svgs/flags/st.svg',
  '{"en":"São Tomé & Príncipe! Learn about the flag of São Tomé & Príncipe!","gu":"સાઓ ટૉમ અને પ્રિંસિપે! સાઓ ટૉમ અને પ્રિંસિપે દેશના ધ્વજ વિશે જાણો!","hi":"साओ टोम और प्रिंसिपे! साओ टोम और प्रिंसिपे के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of São Tomé & Príncipe. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ સાઓ ટૉમ અને પ્રિંસિપે દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह साओ टोम और प्रिंसिपे का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of São Tomé & Príncipe is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? સાઓ ટૉમ અને પ્રિંસિપે નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? साओ टोम और प्रिंसिपे का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  189
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'sa',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Saudi Arabia","gu":"સાઉદી અરેબિયા","hi":"सऊदी अरब"}'::jsonb,
  'assets/svgs/flags/sa.svg',
  '{"en":"Saudi Arabia! Learn about the flag of Saudi Arabia!","gu":"સાઉદી અરેબિયા! સાઉદી અરેબિયા દેશના ધ્વજ વિશે જાણો!","hi":"सऊदी अरब! सऊदी अरब के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Saudi Arabia. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ સાઉદી અરેબિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह सऊदी अरब का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Saudi Arabia is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? સાઉદી અરેબિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? सऊदी अरब का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  190
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'gb-sct',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Scotland","gu":"સ્કોટલેન્ડ","hi":"स्कॉटलैंड"}'::jsonb,
  'assets/svgs/flags/gb-sct.svg',
  '{"en":"Scotland! Learn about the flag of Scotland!","gu":"સ્કોટલેન્ડ! સ્કોટલેન્ડ દેશના ધ્વજ વિશે જાણો!","hi":"स्कॉटलैंड! स्कॉटलैंड के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Scotland. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ સ્કોટલેન્ડ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह स्कॉटलैंड का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Scotland is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? સ્કોટલેન્ડ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? स्कॉटलैंड का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  191
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'sn',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Senegal","gu":"સેનેગલ","hi":"सेनेगल"}'::jsonb,
  'assets/svgs/flags/sn.svg',
  '{"en":"Senegal! Learn about the flag of Senegal!","gu":"સેનેગલ! સેનેગલ દેશના ધ્વજ વિશે જાણો!","hi":"सेनेगल! सेनेगल के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Senegal. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ સેનેગલ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह सेनेगल का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Senegal is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? સેનેગલ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? सेनेगल का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  192
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'rs',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Serbia","gu":"સર્બિયા","hi":"सर्बिया"}'::jsonb,
  'assets/svgs/flags/rs.svg',
  '{"en":"Serbia! Learn about the flag of Serbia!","gu":"સર્બિયા! સર્બિયા દેશના ધ્વજ વિશે જાણો!","hi":"सर्बिया! सर्बिया के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Serbia. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ સર્બિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह सर्बिया का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Serbia is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? સર્બિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? सर्बिया का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  193
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'sc',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Seychelles","gu":"સેશેલ્સ","hi":"सेशेल्स"}'::jsonb,
  'assets/svgs/flags/sc.svg',
  '{"en":"Seychelles! Learn about the flag of Seychelles!","gu":"સેશેલ્સ! સેશેલ્સ દેશના ધ્વજ વિશે જાણો!","hi":"सेशेल्स! सेशेल्स के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Seychelles. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ સેશેલ્સ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह सेशेल्स का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Seychelles is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? સેશેલ્સ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? सेशेल्स का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  194
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'sl',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Sierra Leone","gu":"સીએરા લેઓન","hi":"सिएरा लियोन"}'::jsonb,
  'assets/svgs/flags/sl.svg',
  '{"en":"Sierra Leone! Learn about the flag of Sierra Leone!","gu":"સીએરા લેઓન! સીએરા લેઓન દેશના ધ્વજ વિશે જાણો!","hi":"सिएरा लियोन! सिएरा लियोन के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Sierra Leone. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ સીએરા લેઓન દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह सिएरा लियोन का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Sierra Leone is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? સીએરા લેઓન નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? सिएरा लियोन का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  195
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'sg',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Singapore","gu":"સિંગાપુર","hi":"सिंगापुर"}'::jsonb,
  'assets/svgs/flags/sg.svg',
  '{"en":"Singapore! Learn about the flag of Singapore!","gu":"સિંગાપુર! સિંગાપુર દેશના ધ્વજ વિશે જાણો!","hi":"सिंगापुर! सिंगापुर के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Singapore. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ સિંગાપુર દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह सिंगापुर का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Singapore is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? સિંગાપુર નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? सिंगापुर का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  196
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'sx',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Sint Maarten","gu":"સિંટ માર્ટેન","hi":"सिंट मार्टिन"}'::jsonb,
  'assets/svgs/flags/sx.svg',
  '{"en":"Sint Maarten! Learn about the flag of Sint Maarten!","gu":"સિંટ માર્ટેન! સિંટ માર્ટેન દેશના ધ્વજ વિશે જાણો!","hi":"सिंट मार्टिन! सिंट मार्टिन के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Sint Maarten. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ સિંટ માર્ટેન દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह सिंट मार्टिन का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Sint Maarten is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? સિંટ માર્ટેન નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? सिंट मार्टिन का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  197
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'sk',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Slovakia","gu":"સ્લોવેકિયા","hi":"स्लोवाकिया"}'::jsonb,
  'assets/svgs/flags/sk.svg',
  '{"en":"Slovakia! Learn about the flag of Slovakia!","gu":"સ્લોવેકિયા! સ્લોવેકિયા દેશના ધ્વજ વિશે જાણો!","hi":"स्लोवाकिया! स्लोवाकिया के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Slovakia. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ સ્લોવેકિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह स्लोवाकिया का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Slovakia is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? સ્લોવેકિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? स्लोवाकिया का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  198
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'si',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Slovenia","gu":"સ્લોવેનિયા","hi":"स्लोवेनिया"}'::jsonb,
  'assets/svgs/flags/si.svg',
  '{"en":"Slovenia! Learn about the flag of Slovenia!","gu":"સ્લોવેનિયા! સ્લોવેનિયા દેશના ધ્વજ વિશે જાણો!","hi":"स्लोवेनिया! स्लोवेनिया के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Slovenia. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ સ્લોવેનિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह स्लोवेनिया का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Slovenia is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? સ્લોવેનિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? स्लोवेनिया का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  199
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'sb',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Solomon Islands","gu":"સોલોમન આઇલેન્ડ્સ","hi":"सोलोमन द्वीपसमूह"}'::jsonb,
  'assets/svgs/flags/sb.svg',
  '{"en":"Solomon Islands! Learn about the flag of Solomon Islands!","gu":"સોલોમન આઇલેન્ડ્સ! સોલોમન આઇલેન્ડ્સ દેશના ધ્વજ વિશે જાણો!","hi":"सोलोमन द्वीपसमूह! सोलोमन द्वीपसमूह के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Solomon Islands. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ સોલોમન આઇલેન્ડ્સ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह सोलोमन द्वीपसमूह का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Solomon Islands is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? સોલોમન આઇલેન્ડ્સ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? सोलोमन द्वीपसमूह का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  200
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'so',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Somalia","gu":"સોમાલિયા","hi":"सोमालिया"}'::jsonb,
  'assets/svgs/flags/so.svg',
  '{"en":"Somalia! Learn about the flag of Somalia!","gu":"સોમાલિયા! સોમાલિયા દેશના ધ્વજ વિશે જાણો!","hi":"सोमालिया! सोमालिया के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Somalia. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ સોમાલિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह सोमालिया का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Somalia is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? સોમાલિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? सोमालिया का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  201
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'za',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"South Africa","gu":"દક્ષિણ આફ્રિકા","hi":"दक्षिण अफ़्रीका"}'::jsonb,
  'assets/svgs/flags/za.svg',
  '{"en":"South Africa! Learn about the flag of South Africa!","gu":"દક્ષિણ આફ્રિકા! દક્ષિણ આફ્રિકા દેશના ધ્વજ વિશે જાણો!","hi":"दक्षिण अफ़्रीका! दक्षिण अफ़्रीका के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of South Africa. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ દક્ષિણ આફ્રિકા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह दक्षिण अफ़्रीका का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of South Africa is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? દક્ષિણ આફ્રિકા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? दक्षिण अफ़्रीका का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  202
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'gs',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"South Georgia & South Sandwich Islands","gu":"દક્ષિણ જ્યોર્જિયા અને દક્ષિણ સેન્ડવિચ આઇલેન્ડ્સ","hi":"दक्षिण जॉर्जिया और दक्षिण सैंडविच द्वीपसमूह"}'::jsonb,
  'assets/svgs/flags/gs.svg',
  '{"en":"South Georgia & South Sandwich Islands! Learn about the flag of South Georgia & South Sandwich Islands!","gu":"દક્ષિણ જ્યોર્જિયા અને દક્ષિણ સેન્ડવિચ આઇલેન્ડ્સ! દક્ષિણ જ્યોર્જિયા અને દક્ષિણ સેન્ડવિચ આઇલેન્ડ્સ દેશના ધ્વજ વિશે જાણો!","hi":"दक्षिण जॉर्जिया और दक्षिण सैंडविच द्वीपसमूह! दक्षिण जॉर्जिया और दक्षिण सैंडविच द्वीपसमूह के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of South Georgia & South Sandwich Islands. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ દક્ષિણ જ્યોર્જિયા અને દક્ષિણ સેન્ડવિચ આઇલેન્ડ્સ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह दक्षिण जॉर्जिया और दक्षिण सैंडविच द्वीपसमूह का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of South Georgia & South Sandwich Islands is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? દક્ષિણ જ્યોર્જિયા અને દક્ષિણ સેન્ડવિચ આઇલેન્ડ્સ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? दक्षिण जॉर्जिया और दक्षिण सैंडविच द्वीपसमूह का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  203
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'kr',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"South Korea","gu":"દક્ષિણ કોરિયા","hi":"दक्षिण कोरिया"}'::jsonb,
  'assets/svgs/flags/kr.svg',
  '{"en":"South Korea! Learn about the flag of South Korea!","gu":"દક્ષિણ કોરિયા! દક્ષિણ કોરિયા દેશના ધ્વજ વિશે જાણો!","hi":"दक्षिण कोरिया! दक्षिण कोरिया के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of South Korea. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ દક્ષિણ કોરિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह दक्षिण कोरिया का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of South Korea is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? દક્ષિણ કોરિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? दक्षिण कोरिया का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  204
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ss',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"South Sudan","gu":"દક્ષિણ સુદાન","hi":"दक्षिण सूडान"}'::jsonb,
  'assets/svgs/flags/ss.svg',
  '{"en":"South Sudan! Learn about the flag of South Sudan!","gu":"દક્ષિણ સુદાન! દક્ષિણ સુદાન દેશના ધ્વજ વિશે જાણો!","hi":"दक्षिण सूडान! दक्षिण सूडान के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of South Sudan. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ દક્ષિણ સુદાન દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह दक्षिण सूडान का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of South Sudan is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? દક્ષિણ સુદાન નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? दक्षिण सूडान का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  205
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'es',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Spain","gu":"સ્પેન","hi":"स्पेन"}'::jsonb,
  'assets/svgs/flags/es.svg',
  '{"en":"Spain! Learn about the flag of Spain!","gu":"સ્પેન! સ્પેન દેશના ધ્વજ વિશે જાણો!","hi":"स्पेन! स्पेन के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Spain. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ સ્પેન દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह स्पेन का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Spain is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? સ્પેન નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? स्पेन का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  206
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'lk',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Sri Lanka","gu":"શ્રીલંકા","hi":"श्रीलंका"}'::jsonb,
  'assets/svgs/flags/lk.svg',
  '{"en":"Sri Lanka! Learn about the flag of Sri Lanka!","gu":"શ્રીલંકા! શ્રીલંકા દેશના ધ્વજ વિશે જાણો!","hi":"श्रीलंका! श्रीलंका के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Sri Lanka. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ શ્રીલંકા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह श्रीलंका का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Sri Lanka is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? શ્રીલંકા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? श्रीलंका का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  207
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'bl',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"St. Barthélemy","gu":"સેંટ બાર્થેલેમી","hi":"सेंट बार्थेलेमी"}'::jsonb,
  'assets/svgs/flags/bl.svg',
  '{"en":"St. Barthélemy! Learn about the flag of St. Barthélemy!","gu":"સેંટ બાર્થેલેમી! સેંટ બાર્થેલેમી દેશના ધ્વજ વિશે જાણો!","hi":"सेंट बार्थेलेमी! सेंट बार्थेलेमी के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of St. Barthélemy. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ સેંટ બાર્થેલેમી દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह सेंट बार्थेलेमी का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of St. Barthélemy is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? સેંટ બાર્થેલેમી નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? सेंट बार्थेलेमी का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  208
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'sh',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"St. Helena","gu":"સેંટ હેલેના","hi":"सेंट हेलेना"}'::jsonb,
  'assets/svgs/flags/sh.svg',
  '{"en":"St. Helena! Learn about the flag of St. Helena!","gu":"સેંટ હેલેના! સેંટ હેલેના દેશના ધ્વજ વિશે જાણો!","hi":"सेंट हेलेना! सेंट हेलेना के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of St. Helena. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ સેંટ હેલેના દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह सेंट हेलेना का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of St. Helena is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? સેંટ હેલેના નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? सेंट हेलेना का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  209
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'kn',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"St. Kitts & Nevis","gu":"સેંટ કિટ્સ અને નેવિસ","hi":"सेंट किट्स और नेविस"}'::jsonb,
  'assets/svgs/flags/kn.svg',
  '{"en":"St. Kitts & Nevis! Learn about the flag of St. Kitts & Nevis!","gu":"સેંટ કિટ્સ અને નેવિસ! સેંટ કિટ્સ અને નેવિસ દેશના ધ્વજ વિશે જાણો!","hi":"सेंट किट्स और नेविस! सेंट किट्स और नेविस के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of St. Kitts & Nevis. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ સેંટ કિટ્સ અને નેવિસ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह सेंट किट्स और नेविस का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of St. Kitts & Nevis is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? સેંટ કિટ્સ અને નેવિસ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? सेंट किट्स और नेविस का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  210
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'lc',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"St. Lucia","gu":"સેંટ લુસિયા","hi":"सेंट लूसिया"}'::jsonb,
  'assets/svgs/flags/lc.svg',
  '{"en":"St. Lucia! Learn about the flag of St. Lucia!","gu":"સેંટ લુસિયા! સેંટ લુસિયા દેશના ધ્વજ વિશે જાણો!","hi":"सेंट लूसिया! सेंट लूसिया के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of St. Lucia. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ સેંટ લુસિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह सेंट लूसिया का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of St. Lucia is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? સેંટ લુસિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? सेंट लूसिया का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  211
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'mf',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"St. Martin","gu":"સેંટ માર્ટિન","hi":"सेंट मार्टिन"}'::jsonb,
  'assets/svgs/flags/mf.svg',
  '{"en":"St. Martin! Learn about the flag of St. Martin!","gu":"સેંટ માર્ટિન! સેંટ માર્ટિન દેશના ધ્વજ વિશે જાણો!","hi":"सेंट मार्टिन! सेंट मार्टिन के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of St. Martin. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ સેંટ માર્ટિન દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह सेंट मार्टिन का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of St. Martin is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? સેંટ માર્ટિન નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? सेंट मार्टिन का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  212
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'pm',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"St. Pierre & Miquelon","gu":"સેંટ પીએરી અને મિક્યુલોન","hi":"सेंट पिएरे और मिक्वेलान"}'::jsonb,
  'assets/svgs/flags/pm.svg',
  '{"en":"St. Pierre & Miquelon! Learn about the flag of St. Pierre & Miquelon!","gu":"સેંટ પીએરી અને મિક્યુલોન! સેંટ પીએરી અને મિક્યુલોન દેશના ધ્વજ વિશે જાણો!","hi":"सेंट पिएरे और मिक्वेलान! सेंट पिएरे और मिक्वेलान के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of St. Pierre & Miquelon. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ સેંટ પીએરી અને મિક્યુલોન દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह सेंट पिएरे और मिक्वेलान का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of St. Pierre & Miquelon is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? સેંટ પીએરી અને મિક્યુલોન નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? सेंट पिएरे और मिक्वेलान का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  213
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'vc',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"St. Vincent & Grenadines","gu":"સેંટ વિન્સેંટ અને ગ્રેનેડાઇંસ","hi":"सेंट विंसेंट और ग्रेनाडाइंस"}'::jsonb,
  'assets/svgs/flags/vc.svg',
  '{"en":"St. Vincent & Grenadines! Learn about the flag of St. Vincent & Grenadines!","gu":"સેંટ વિન્સેંટ અને ગ્રેનેડાઇંસ! સેંટ વિન્સેંટ અને ગ્રેનેડાઇંસ દેશના ધ્વજ વિશે જાણો!","hi":"सेंट विंसेंट और ग्रेनाडाइंस! सेंट विंसेंट और ग्रेनाडाइंस के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of St. Vincent & Grenadines. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ સેંટ વિન્સેંટ અને ગ્રેનેડાઇંસ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह सेंट विंसेंट और ग्रेनाडाइंस का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of St. Vincent & Grenadines is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? સેંટ વિન્સેંટ અને ગ્રેનેડાઇંસ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? सेंट विंसेंट और ग्रेनाडाइंस का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  214
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'sd',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Sudan","gu":"સુદાન","hi":"सूडान"}'::jsonb,
  'assets/svgs/flags/sd.svg',
  '{"en":"Sudan! Learn about the flag of Sudan!","gu":"સુદાન! સુદાન દેશના ધ્વજ વિશે જાણો!","hi":"सूडान! सूडान के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Sudan. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ સુદાન દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह सूडान का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Sudan is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? સુદાન નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? सूडान का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  215
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'sr',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Suriname","gu":"સુરીનામ","hi":"सूरीनाम"}'::jsonb,
  'assets/svgs/flags/sr.svg',
  '{"en":"Suriname! Learn about the flag of Suriname!","gu":"સુરીનામ! સુરીનામ દેશના ધ્વજ વિશે જાણો!","hi":"सूरीनाम! सूरीनाम के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Suriname. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ સુરીનામ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह सूरीनाम का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Suriname is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? સુરીનામ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? सूरीनाम का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  216
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'sj',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Svalbard & Jan Mayen","gu":"સ્વાલબર્ડ અને જેન મેયન","hi":"स्वालबार्ड और जान मायेन"}'::jsonb,
  'assets/svgs/flags/sj.svg',
  '{"en":"Svalbard & Jan Mayen! Learn about the flag of Svalbard & Jan Mayen!","gu":"સ્વાલબર્ડ અને જેન મેયન! સ્વાલબર્ડ અને જેન મેયન દેશના ધ્વજ વિશે જાણો!","hi":"स्वालबार्ड और जान मायेन! स्वालबार्ड और जान मायेन के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Svalbard & Jan Mayen. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ સ્વાલબર્ડ અને જેન મેયન દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह स्वालबार्ड और जान मायेन का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Svalbard & Jan Mayen is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? સ્વાલબર્ડ અને જેન મેયન નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? स्वालबार्ड और जान मायेन का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  217
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'se',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Sweden","gu":"સ્વીડન","hi":"स्वीडन"}'::jsonb,
  'assets/svgs/flags/se.svg',
  '{"en":"Sweden! Learn about the flag of Sweden!","gu":"સ્વીડન! સ્વીડન દેશના ધ્વજ વિશે જાણો!","hi":"स्वीडन! स्वीडन के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Sweden. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ સ્વીડન દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह स्वीडन का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Sweden is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? સ્વીડન નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? स्वीडन का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  218
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ch',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Switzerland","gu":"સ્વિટ્ઝર્લૅન્ડ","hi":"स्विट्ज़रलैंड"}'::jsonb,
  'assets/svgs/flags/ch.svg',
  '{"en":"Switzerland! Learn about the flag of Switzerland!","gu":"સ્વિટ્ઝર્લૅન્ડ! સ્વિટ્ઝર્લૅન્ડ દેશના ધ્વજ વિશે જાણો!","hi":"स्विट्ज़रलैंड! स्विट्ज़रलैंड के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Switzerland. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ સ્વિટ્ઝર્લૅન્ડ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह स्विट्ज़रलैंड का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Switzerland is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? સ્વિટ્ઝર્લૅન્ડ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? स्विट्ज़रलैंड का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  219
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'sy',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Syria","gu":"સીરિયા","hi":"सीरिया"}'::jsonb,
  'assets/svgs/flags/sy.svg',
  '{"en":"Syria! Learn about the flag of Syria!","gu":"સીરિયા! સીરિયા દેશના ધ્વજ વિશે જાણો!","hi":"सीरिया! सीरिया के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Syria. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ સીરિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह सीरिया का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Syria is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? સીરિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? सीरिया का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  220
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'tw',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Taiwan","gu":"તાઇવાન","hi":"ताइवान"}'::jsonb,
  'assets/svgs/flags/tw.svg',
  '{"en":"Taiwan! Learn about the flag of Taiwan!","gu":"તાઇવાન! તાઇવાન દેશના ધ્વજ વિશે જાણો!","hi":"ताइवान! ताइवान के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Taiwan. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ તાઇવાન દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह ताइवान का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Taiwan is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? તાઇવાન નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? ताइवान का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  221
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'tj',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Tajikistan","gu":"તાજીકિસ્તાન","hi":"ताज़िकिस्तान"}'::jsonb,
  'assets/svgs/flags/tj.svg',
  '{"en":"Tajikistan! Learn about the flag of Tajikistan!","gu":"તાજીકિસ્તાન! તાજીકિસ્તાન દેશના ધ્વજ વિશે જાણો!","hi":"ताज़िकिस्तान! ताज़िकिस्तान के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Tajikistan. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ તાજીકિસ્તાન દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह ताज़िकिस्तान का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Tajikistan is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? તાજીકિસ્તાન નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? ताज़िकिस्तान का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  222
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'tz',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Tanzania","gu":"તાંઝાનિયા","hi":"तंज़ानिया"}'::jsonb,
  'assets/svgs/flags/tz.svg',
  '{"en":"Tanzania! Learn about the flag of Tanzania!","gu":"તાંઝાનિયા! તાંઝાનિયા દેશના ધ્વજ વિશે જાણો!","hi":"तंज़ानिया! तंज़ानिया के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Tanzania. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ તાંઝાનિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह तंज़ानिया का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Tanzania is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? તાંઝાનિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? तंज़ानिया का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  223
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'th',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Thailand","gu":"થાઇલેંડ","hi":"थाईलैंड"}'::jsonb,
  'assets/svgs/flags/th.svg',
  '{"en":"Thailand! Learn about the flag of Thailand!","gu":"થાઇલેંડ! થાઇલેંડ દેશના ધ્વજ વિશે જાણો!","hi":"थाईलैंड! थाईलैंड के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Thailand. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ થાઇલેંડ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह थाईलैंड का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Thailand is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? થાઇલેંડ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? थाईलैंड का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  224
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'tl',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Timor-Leste","gu":"તિમોર-લેસ્તે","hi":"तिमोर-लेस्त"}'::jsonb,
  'assets/svgs/flags/tl.svg',
  '{"en":"Timor-Leste! Learn about the flag of Timor-Leste!","gu":"તિમોર-લેસ્તે! તિમોર-લેસ્તે દેશના ધ્વજ વિશે જાણો!","hi":"तिमोर-लेस्त! तिमोर-लेस्त के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Timor-Leste. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ તિમોર-લેસ્તે દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह तिमोर-लेस्त का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Timor-Leste is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? તિમોર-લેસ્તે નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? तिमोर-लेस्त का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  225
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'tg',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Togo","gu":"ટોગો","hi":"टोगो"}'::jsonb,
  'assets/svgs/flags/tg.svg',
  '{"en":"Togo! Learn about the flag of Togo!","gu":"ટોગો! ટોગો દેશના ધ્વજ વિશે જાણો!","hi":"टोगो! टोगो के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Togo. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ટોગો દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह टोगो का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Togo is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ટોગો નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? टोगो का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  226
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'tk',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Tokelau","gu":"ટોકેલાઉ","hi":"तोकेलाउ"}'::jsonb,
  'assets/svgs/flags/tk.svg',
  '{"en":"Tokelau! Learn about the flag of Tokelau!","gu":"ટોકેલાઉ! ટોકેલાઉ દેશના ધ્વજ વિશે જાણો!","hi":"तोकेलाउ! तोकेलाउ के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Tokelau. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ટોકેલાઉ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह तोकेलाउ का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Tokelau is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ટોકેલાઉ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? तोकेलाउ का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  227
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'to',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Tonga","gu":"ટોંગા","hi":"टोंगा"}'::jsonb,
  'assets/svgs/flags/to.svg',
  '{"en":"Tonga! Learn about the flag of Tonga!","gu":"ટોંગા! ટોંગા દેશના ધ્વજ વિશે જાણો!","hi":"टोंगा! टोंगा के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Tonga. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ટોંગા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह टोंगा का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Tonga is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ટોંગા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? टोंगा का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  228
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'tt',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Trinidad & Tobago","gu":"ટ્રિનીદાદ અને ટોબેગો","hi":"त्रिनिदाद और टोबैगो"}'::jsonb,
  'assets/svgs/flags/tt.svg',
  '{"en":"Trinidad & Tobago! Learn about the flag of Trinidad & Tobago!","gu":"ટ્રિનીદાદ અને ટોબેગો! ટ્રિનીદાદ અને ટોબેગો દેશના ધ્વજ વિશે જાણો!","hi":"त्रिनिदाद और टोबैगो! त्रिनिदाद और टोबैगो के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Trinidad & Tobago. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ટ્રિનીદાદ અને ટોબેગો દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह त्रिनिदाद और टोबैगो का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Trinidad & Tobago is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ટ્રિનીદાદ અને ટોબેગો નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? त्रिनिदाद और टोबैगो का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  229
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'tn',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Tunisia","gu":"ટ્યુનિશિયા","hi":"ट्यूनीशिया"}'::jsonb,
  'assets/svgs/flags/tn.svg',
  '{"en":"Tunisia! Learn about the flag of Tunisia!","gu":"ટ્યુનિશિયા! ટ્યુનિશિયા દેશના ધ્વજ વિશે જાણો!","hi":"ट्यूनीशिया! ट्यूनीशिया के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Tunisia. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ટ્યુનિશિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह ट्यूनीशिया का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Tunisia is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ટ્યુનિશિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? ट्यूनीशिया का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  230
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'tr',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Turkey","gu":"તુર્કી","hi":"तुर्की"}'::jsonb,
  'assets/svgs/flags/tr.svg',
  '{"en":"Turkey! Learn about the flag of Turkey!","gu":"તુર્કી! તુર્કી દેશના ધ્વજ વિશે જાણો!","hi":"तुर्की! तुर्की के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Turkey. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ તુર્કી દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह तुर्की का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Turkey is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? તુર્કી નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? तुर्की का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  231
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'tm',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Turkmenistan","gu":"તુર્કમેનિસ્તાન","hi":"तुर्कमेनिस्तान"}'::jsonb,
  'assets/svgs/flags/tm.svg',
  '{"en":"Turkmenistan! Learn about the flag of Turkmenistan!","gu":"તુર્કમેનિસ્તાન! તુર્કમેનિસ્તાન દેશના ધ્વજ વિશે જાણો!","hi":"तुर्कमेनिस्तान! तुर्कमेनिस्तान के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Turkmenistan. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ તુર્કમેનિસ્તાન દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह तुर्कमेनिस्तान का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Turkmenistan is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? તુર્કમેનિસ્તાન નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? तुर्कमेनिस्तान का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  232
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'tc',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Turks & Caicos Islands","gu":"તુર્ક્સ અને કેકોઝ આઇલેન્ડ્સ","hi":"तुर्क और कैकोज़ द्वीपसमूह"}'::jsonb,
  'assets/svgs/flags/tc.svg',
  '{"en":"Turks & Caicos Islands! Learn about the flag of Turks & Caicos Islands!","gu":"તુર્ક્સ અને કેકોઝ આઇલેન્ડ્સ! તુર્ક્સ અને કેકોઝ આઇલેન્ડ્સ દેશના ધ્વજ વિશે જાણો!","hi":"तुर्क और कैकोज़ द्वीपसमूह! तुर्क और कैकोज़ द्वीपसमूह के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Turks & Caicos Islands. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ તુર્ક્સ અને કેકોઝ આઇલેન્ડ્સ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह तुर्क और कैकोज़ द्वीपसमूह का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Turks & Caicos Islands is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? તુર્ક્સ અને કેકોઝ આઇલેન્ડ્સ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? तुर्क और कैकोज़ द्वीपसमूह का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  233
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'tv',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Tuvalu","gu":"તુવાલુ","hi":"तुवालू"}'::jsonb,
  'assets/svgs/flags/tv.svg',
  '{"en":"Tuvalu! Learn about the flag of Tuvalu!","gu":"તુવાલુ! તુવાલુ દેશના ધ્વજ વિશે જાણો!","hi":"तुवालू! तुवालू के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Tuvalu. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ તુવાલુ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह तुवालू का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Tuvalu is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? તુવાલુ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? तुवालू का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  234
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'um',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"U.S. Outlying Islands","gu":"યુ.એસ. આઉટલાઇનિંગ આઇલેન્ડ્સ","hi":"यू॰एस॰ आउटलाइंग द्वीपसमूह"}'::jsonb,
  'assets/svgs/flags/um.svg',
  '{"en":"U.S. Outlying Islands! Learn about the flag of U.S. Outlying Islands!","gu":"યુ.એસ. આઉટલાઇનિંગ આઇલેન્ડ્સ! યુ.એસ. આઉટલાઇનિંગ આઇલેન્ડ્સ દેશના ધ્વજ વિશે જાણો!","hi":"यू॰एस॰ आउटलाइंग द्वीपसमूह! यू॰एस॰ आउटलाइंग द्वीपसमूह के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of U.S. Outlying Islands. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ યુ.એસ. આઉટલાઇનિંગ આઇલેન્ડ્સ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह यू॰एस॰ आउटलाइंग द्वीपसमूह का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of U.S. Outlying Islands is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? યુ.એસ. આઉટલાઇનિંગ આઇલેન્ડ્સ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? यू॰एस॰ आउटलाइंग द्वीपसमूह का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  235
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'vi',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"U.S. Virgin Islands","gu":"યુએસ વર્જિન આઇલેન્ડ્સ","hi":"यू॰एस॰ वर्जिन द्वीपसमूह"}'::jsonb,
  'assets/svgs/flags/vi.svg',
  '{"en":"U.S. Virgin Islands! Learn about the flag of U.S. Virgin Islands!","gu":"યુએસ વર્જિન આઇલેન્ડ્સ! યુએસ વર્જિન આઇલેન્ડ્સ દેશના ધ્વજ વિશે જાણો!","hi":"यू॰एस॰ वर्जिन द्वीपसमूह! यू॰एस॰ वर्जिन द्वीपसमूह के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of U.S. Virgin Islands. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ યુએસ વર્જિન આઇલેન્ડ્સ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह यू॰एस॰ वर्जिन द्वीपसमूह का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of U.S. Virgin Islands is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? યુએસ વર્જિન આઇલેન્ડ્સ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? यू॰एस॰ वर्जिन द्वीपसमूह का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  236
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ug',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Uganda","gu":"યુગાંડા","hi":"युगांडा"}'::jsonb,
  'assets/svgs/flags/ug.svg',
  '{"en":"Uganda! Learn about the flag of Uganda!","gu":"યુગાંડા! યુગાંડા દેશના ધ્વજ વિશે જાણો!","hi":"युगांडा! युगांडा के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Uganda. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ યુગાંડા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह युगांडा का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Uganda is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? યુગાંડા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? युगांडा का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  237
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ua',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Ukraine","gu":"યુક્રેન","hi":"यूक्रेन"}'::jsonb,
  'assets/svgs/flags/ua.svg',
  '{"en":"Ukraine! Learn about the flag of Ukraine!","gu":"યુક્રેન! યુક્રેન દેશના ધ્વજ વિશે જાણો!","hi":"यूक्रेन! यूक्रेन के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Ukraine. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ યુક્રેન દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह यूक्रेन का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Ukraine is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? યુક્રેન નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? यूक्रेन का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  238
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ae',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"United Arab Emirates","gu":"યુનાઇટેડ આરબ અમીરાત","hi":"संयुक्त अरब अमीरात"}'::jsonb,
  'assets/svgs/flags/ae.svg',
  '{"en":"United Arab Emirates! Learn about the flag of United Arab Emirates!","gu":"યુનાઇટેડ આરબ અમીરાત! યુનાઇટેડ આરબ અમીરાત દેશના ધ્વજ વિશે જાણો!","hi":"संयुक्त अरब अमीरात! संयुक्त अरब अमीरात के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of United Arab Emirates. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ યુનાઇટેડ આરબ અમીરાત દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह संयुक्त अरब अमीरात का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of United Arab Emirates is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? યુનાઇટેડ આરબ અમીરાત નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? संयुक्त अरब अमीरात का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  239
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'gb',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"United Kingdom","gu":"યુનાઇટેડ કિંગડમ","hi":"यूनाइटेड किंगडम"}'::jsonb,
  'assets/svgs/flags/gb.svg',
  '{"en":"United Kingdom! Learn about the flag of United Kingdom!","gu":"યુનાઇટેડ કિંગડમ! યુનાઇટેડ કિંગડમ દેશના ધ્વજ વિશે જાણો!","hi":"यूनाइटेड किंगडम! यूनाइटेड किंगडम के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of United Kingdom. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ યુનાઇટેડ કિંગડમ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह यूनाइटेड किंगडम का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of United Kingdom is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? યુનાઇટેડ કિંગડમ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? यूनाइटेड किंगडम का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  240
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'us',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"United States","gu":"યુનાઇટેડ સ્ટેટ્સ","hi":"संयुक्त राज्य"}'::jsonb,
  'assets/svgs/flags/us.svg',
  '{"en":"United States! Learn about the flag of United States!","gu":"યુનાઇટેડ સ્ટેટ્સ! યુનાઇટેડ સ્ટેટ્સ દેશના ધ્વજ વિશે જાણો!","hi":"संयुक्त राज्य! संयुक्त राज्य के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of United States. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ યુનાઇટેડ સ્ટેટ્સ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह संयुक्त राज्य का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of United States is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? યુનાઇટેડ સ્ટેટ્સ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? संयुक्त राज्य का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  241
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'uy',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Uruguay","gu":"ઉરુગ્વે","hi":"उरूग्वे"}'::jsonb,
  'assets/svgs/flags/uy.svg',
  '{"en":"Uruguay! Learn about the flag of Uruguay!","gu":"ઉરુગ્વે! ઉરુગ્વે દેશના ધ્વજ વિશે જાણો!","hi":"उरूग्वे! उरूग्वे के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Uruguay. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ઉરુગ્વે દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह उरूग्वे का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Uruguay is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ઉરુગ્વે નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? उरूग्वे का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  242
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'uz',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Uzbekistan","gu":"ઉઝ્બેકિસ્તાન","hi":"उज़्बेकिस्तान"}'::jsonb,
  'assets/svgs/flags/uz.svg',
  '{"en":"Uzbekistan! Learn about the flag of Uzbekistan!","gu":"ઉઝ્બેકિસ્તાન! ઉઝ્બેકિસ્તાન દેશના ધ્વજ વિશે જાણો!","hi":"उज़्बेकिस्तान! उज़्बेकिस्तान के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Uzbekistan. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ઉઝ્બેકિસ્તાન દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह उज़्बेकिस्तान का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Uzbekistan is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ઉઝ્બેકિસ્તાન નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? उज़्बेकिस्तान का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  243
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'vu',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Vanuatu","gu":"વાનુઆતુ","hi":"वनुआतू"}'::jsonb,
  'assets/svgs/flags/vu.svg',
  '{"en":"Vanuatu! Learn about the flag of Vanuatu!","gu":"વાનુઆતુ! વાનુઆતુ દેશના ધ્વજ વિશે જાણો!","hi":"वनुआतू! वनुआतू के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Vanuatu. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ વાનુઆતુ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह वनुआतू का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Vanuatu is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? વાનુઆતુ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? वनुआतू का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  244
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'va',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Vatican City","gu":"વેટિકન સિટી","hi":"वेटिकन सिटी"}'::jsonb,
  'assets/svgs/flags/va.svg',
  '{"en":"Vatican City! Learn about the flag of Vatican City!","gu":"વેટિકન સિટી! વેટિકન સિટી દેશના ધ્વજ વિશે જાણો!","hi":"वेटिकन सिटी! वेटिकन सिटी के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Vatican City. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ વેટિકન સિટી દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह वेटिकन सिटी का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Vatican City is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? વેટિકન સિટી નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? वेटिकन सिटी का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  245
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  've',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Venezuela","gu":"વેનેઝુએલા","hi":"वेनेज़ुएला"}'::jsonb,
  'assets/svgs/flags/ve.svg',
  '{"en":"Venezuela! Learn about the flag of Venezuela!","gu":"વેનેઝુએલા! વેનેઝુએલા દેશના ધ્વજ વિશે જાણો!","hi":"वेनेज़ुएला! वेनेज़ुएला के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Venezuela. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ વેનેઝુએલા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह वेनेज़ुएला का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Venezuela is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? વેનેઝુએલા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? वेनेज़ुएला का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  246
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'vn',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Vietnam","gu":"વિયેતનામ","hi":"वियतनाम"}'::jsonb,
  'assets/svgs/flags/vn.svg',
  '{"en":"Vietnam! Learn about the flag of Vietnam!","gu":"વિયેતનામ! વિયેતનામ દેશના ધ્વજ વિશે જાણો!","hi":"वियतनाम! वियतनाम के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Vietnam. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ વિયેતનામ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह वियतनाम का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Vietnam is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? વિયેતનામ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? वियतनाम का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  247
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'gb-wls',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Wales","gu":"વેલ્સ","hi":"वेल्स"}'::jsonb,
  'assets/svgs/flags/gb-wls.svg',
  '{"en":"Wales! Learn about the flag of Wales!","gu":"વેલ્સ! વેલ્સ દેશના ધ્વજ વિશે જાણો!","hi":"वेल्स! वेल्स के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Wales. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ વેલ્સ દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह वेल्स का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Wales is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? વેલ્સ નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? वेल्स का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  248
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'wf',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Wallis & Futuna","gu":"વૉલિસ અને ફ્યુચુના","hi":"वालिस और फ़्यूचूना"}'::jsonb,
  'assets/svgs/flags/wf.svg',
  '{"en":"Wallis & Futuna! Learn about the flag of Wallis & Futuna!","gu":"વૉલિસ અને ફ્યુચુના! વૉલિસ અને ફ્યુચુના દેશના ધ્વજ વિશે જાણો!","hi":"वालिस और फ़्यूचूना! वालिस और फ़्यूचूना के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Wallis & Futuna. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ વૉલિસ અને ફ્યુચુના દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह वालिस और फ़्यूचूना का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Wallis & Futuna is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? વૉલિસ અને ફ્યુચુના નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? वालिस और फ़्यूचूना का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  249
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'eh',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Western Sahara","gu":"પશ્ચિમી સહારા","hi":"पश्चिमी सहारा"}'::jsonb,
  'assets/svgs/flags/eh.svg',
  '{"en":"Western Sahara! Learn about the flag of Western Sahara!","gu":"પશ્ચિમી સહારા! પશ્ચિમી સહારા દેશના ધ્વજ વિશે જાણો!","hi":"पश्चिमी सहारा! पश्चिमी सहारा के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Western Sahara. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ પશ્ચિમી સહારા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह पश्चिमी सहारा का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Western Sahara is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? પશ્ચિમી સહારા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? पश्चिमी सहारा का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  250
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'xk',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Kosovo","gu":"કોસોવો","hi":"कोसोवो"}'::jsonb,
  'assets/svgs/flags/xk.svg',
  '{"en":"Kosovo! Learn about the flag of Kosovo!","gu":"કોસોવો! કોસોવો દેશના ધ્વજ વિશે જાણો!","hi":"कोसोवो! कोसोवो के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Kosovo. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ કોસોવો દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह कोसोवो का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Kosovo is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? કોસોવો નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? कोसोवो का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  251
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ye',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Yemen","gu":"યમન","hi":"यमन"}'::jsonb,
  'assets/svgs/flags/ye.svg',
  '{"en":"Yemen! Learn about the flag of Yemen!","gu":"યમન! યમન દેશના ધ્વજ વિશે જાણો!","hi":"यमन! यमन के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Yemen. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ યમન દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह यमन का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Yemen is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? યમન નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? यमन का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  252
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'zm',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Zambia","gu":"ઝામ્બિયા","hi":"ज़ाम्बिया"}'::jsonb,
  'assets/svgs/flags/zm.svg',
  '{"en":"Zambia! Learn about the flag of Zambia!","gu":"ઝામ્બિયા! ઝામ્બિયા દેશના ધ્વજ વિશે જાણો!","hi":"ज़ाम्बिया! ज़ाम्बिया के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Zambia. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ઝામ્બિયા દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह ज़ाम्बिया का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Zambia is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ઝામ્બિયા નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? ज़ाम्बिया का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  253
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.flags (topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'zw',
  (SELECT id FROM categories WHERE category_key = 'flags' LIMIT 1),
  '{"en":"Zimbabwe","gu":"ઝિમ્બાબ્વે","hi":"ज़िम्बाब्वे"}'::jsonb,
  'assets/svgs/flags/zw.svg',
  '{"en":"Zimbabwe! Learn about the flag of Zimbabwe!","gu":"ઝિમ્બાબ્વે! ઝિમ્બાબ્વે દેશના ધ્વજ વિશે જાણો!","hi":"ज़िम्बाब्वे! ज़िम्बाब्वे के राष्ट्रीय ध्वज के बारे में जानें!"}'::jsonb,
  '{"en":"This is the official national flag of Zimbabwe. Each flag uses unique colors and symbols to represent the history, values, and pride of the country.","gu":"આ ઝિમ્બાબ્વે દેશનો સત્તાવાર રાષ્ટ્રીય ધ્વજ છે. દરેક રાષ્ટ્રીય ધ્વજ તેના દેશના ઇતિહાસ, મૂલ્યો અને ગૌરવનું પ્રતિનિધિત્વ કરે છે.","hi":"यह ज़िम्बाब्वे का आधिकारिक राष्ट्रीय ध्वज है। प्रत्येक देश का ध्वज उसके इतिहास, मूल्यों और गौरव को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? The flag of Zimbabwe is unique and is flown proudly at international events all around the world!","gu":"શું તમે જાણો છો? ઝિમ્બાબ્વે નો ધ્વજ અનન્ય છે અને સમગ્ર વિશ્વમાં યોજાતા આંતરરાષ્ટ્રીય કાર્યક્રમોમાં ગર્વથી લહેરાવવામાં આવે છે!","hi":"क्या आपको पता है? ज़िम्बाब्वे का ध्वज अनोखा है और दुनिया भर में होने वाले कार्यक्रमों में गर्व से फहराया जाता है!"}'::jsonb,
  'matching',
  true,
  254
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;
