-- 1. Create emotions table

CREATE TABLE IF NOT EXISTS public.emotions (
  id bigint generated always as identity not null,
  topic_key text not null,
  category_id bigint null,
  name jsonb not null default '{}'::jsonb,
  image_path text null,
  lottie_path text null,
  narration jsonb not null default '{}'::jsonb,
  explanation jsonb not null default '{}'::jsonb,
  fact jsonb not null default '{}'::jsonb,
  hex_code text null,
  game_type text null,
  is_free boolean not null default true,
  display_order integer null,
  constraint emotions_pkey primary key (id),
  constraint emotions_topic_key_key unique (topic_key),
  constraint emotions_category_id_fkey foreign KEY (category_id) references categories (id) on delete CASCADE
) TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS idx_emotions_topic_key on public.emotions using btree (topic_key) TABLESPACE pg_default;

ALTER TABLE public.emotions DISABLE ROW LEVEL SECURITY;

GRANT ALL ON public.emotions TO anon;
GRANT ALL ON public.emotions TO authenticated;
GRANT ALL ON public.emotions TO service_role;


-- 2. Reset sequence & insert category

SELECT setval(
  pg_get_serial_sequence('public.categories', 'id'),
  COALESCE((SELECT MAX(id) FROM public.categories), 0) + 1,
  false
);

INSERT INTO public.categories (category_key, title, color, is_premium, group_id, display_order)
VALUES (
  'emotions',
  '{"en": "Emotions", "gu": "લાગણીઓ", "hi": "भावनाएं"}'::jsonb,
  '#FF9800',
  false,
  'natures_world',
  23
)
ON CONFLICT (category_key) DO UPDATE SET
  title = EXCLUDED.title,
  color = EXCLUDED.color,
  group_id = EXCLUDED.group_id,
  display_order = EXCLUDED.display_order;


-- 3. Seed 20 emotions

INSERT INTO public.emotions (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'happy',
  (SELECT id FROM categories WHERE category_key = 'emotions' LIMIT 1),
  '{"en":"Happy","gu":"ખુશ","hi":"खुश"}'::jsonb,
  'assets/images/emotions/happy.png',
  '#FFD54F',
  '{"en":"Happy! A bright smile and a joyful feeling!","gu":"ખુશ! એક મોટો મધુર સ્મિત અને અતિ સરસ અનુભવ!","hi":"खुश! एक बड़ी मुस्कान और खुशी का अहसास!"}'::jsonb,
  '{"en":"We feel happy when we play with friends, eat our favorite food, or get a nice hug. Smiling actually helps your brain feel even happier!","gu":"જ્યારે આપણે મિત્રો સાથે રમીએ છીએ, આપણી મનપસંદ વાનગી ખાઈએ છીએ, ત્યારે આપણે ખુશ હોઈએ છીએ. સ્મિત કરવાથી આપણું મગજ વધુ ખુશ બને છે!","hi":"जब हम दोस्तों के साथ खेलते हैं, अपनी पसंदीदा चीजें खाते हैं, तो हम खुश महसूस करते हैं। मुस्कुराने से हमारा दिमाग और भी खुश होता है!"}'::jsonb,
  '{"en":"Did you know? Smiling is contagious! When you smile at someone, their brain often makes them smile back without even thinking!","gu":"શું તમે જાણો છો? સ્મિત ચેપી છે! જ્યારે તમે કોઈની સામે હસો છો, ત્યારે તેનું મગજ પણ તેને હસવા માટે પ્રેરિત કરે છે!","hi":"क्या आपको पता है? मुस्कान संक्रामक होती है! जब आप किसी को देखकर मुस्कुराते हैं, तो वे भी खुद-ब-खुद मुस्कुराने लगते हैं!"}'::jsonb,
  'memory',
  true,
  1
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  hex_code = EXCLUDED.hex_code,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.emotions (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'sleepy',
  (SELECT id FROM categories WHERE category_key = 'emotions' LIMIT 1),
  '{"en":"Sleepy","gu":"ઊંઘ આવવી","hi":"नींद आना"}'::jsonb,
  'assets/images/emotions/sleepy.png',
  '#7986CB',
  '{"en":"Sleepy! A big yawn and soft eyes, ready for bed!","gu":"ઊંઘ આવવી! એક મોટું બગાસું અને હળવી આંખો, સુવા માટે તૈયાર!","hi":"नींद आना! एक बड़ी जम्हाई और भारी आंखें, सोने के लिए तैयार!"}'::jsonb,
  '{"en":"We feel sleepy when our body is tired and needs rest. Yawning helps bring more oxygen into our lungs and cool our brain down!","gu":"જ્યારે આપણું શરીર થાકેલું હોય અને આરામની જરૂર હોય ત્યારે આપણને ઊંઘ આવે છે. બગાસું ખાવાથી ફેફસામાં વધુ ઓક્સિજન જાય છે અને મગજ શાંત થાય છે.","hi":"जब हमारा शरीर थक जाता है और उसे आराम की जरूरत होती है, तो हमें नींद आती है। जम्हाई लेने से फेफड़ों में अधिक ऑक्सीजन जाती है।"}'::jsonb,
  '{"en":"Did you know? Koalas are the sleepiest animals in the world — they sleep for up to 22 hours every single day to save energy!","gu":"શું તમે જાણો છો? કોઆલા દુનિયાનું સૌથી વધુ ઊંઘતું પ્રાણી છે, તે ઉર્જા બચાવવા માટે દિવસમાં ૨૨ કલાક ઊંઘે છે!","hi":"क्या आपको पता है? कोआला दुनिया का सबसे अधिक सोने वाला जानवर है, जो ऊर्जा बचाने के लिए दिन में 22 घंटे तक सोता है!"}'::jsonb,
  'memory',
  true,
  2
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  hex_code = EXCLUDED.hex_code,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.emotions (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'angry',
  (SELECT id FROM categories WHERE category_key = 'emotions' LIMIT 1),
  '{"en":"Angry","gu":"ગુસ્સો","hi":"गुस्सा"}'::jsonb,
  'assets/images/emotions/angry.png',
  '#E57373',
  '{"en":"Angry! A frowned face and tight fists — a strong feeling!","gu":"ગુસ્સો! કડક ચહેરો અને બંધ મુઠ્ઠીઓ — એક તીવ્ર લાગણી!","hi":"गुस्सा! तना हुआ चेहरा और बंद मुट्ठियां — एक तीव्र भावना!"}'::jsonb,
  '{"en":"It is normal to feel angry sometimes when things don''t go our way. Taking deep breaths and counting to ten can help calm our body down!","gu":"જ્યારે વસ્તુઓ આપણી ઈચ્છા મુજબ ન થાય ત્યારે ગુસ્સો આવવો સામાન્ય છે. ઊંડા શ્વાસ લેવાથી અને દસ સુધી ગણવાથી આપણું મન શાંત થાય છે.","hi":"जब चीजें हमारे मनमुताबिक नहीं होतीं, तो कभी-कभी गुस्सा आना सामान्य है। गहरे सांस लेने से हमारा शरीर शांत होता है।"}'::jsonb,
  '{"en":"Did you know? Anger makes our heart beat faster and sends extra energy to our muscles, preparing us to react quickly!","gu":"શું તમે જાણો છો? ગુસ્સાને લીધે આપણા હૃદયના ધબકારા વધે છે અને સ્નાયુઓમાં વધારાની ઉર્જા પહોંચે છે, જેથી આપણે ઝડપી પ્રતિક્રિયા આપી શકીએ.","hi":"क्या आपको पता है? गुस्से में हमारे दिल की धड़कन बढ़ जाती है और मांसपेशियों को अतिरिक्त ऊर्जा मिलती है!"}'::jsonb,
  'memory',
  true,
  3
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  hex_code = EXCLUDED.hex_code,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.emotions (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'tired',
  (SELECT id FROM categories WHERE category_key = 'emotions' LIMIT 1),
  '{"en":"Tired","gu":"થાકેલું","hi":"थका हुआ"}'::jsonb,
  'assets/images/emotions/tired.png',
  '#A1887F',
  '{"en":"Tired! A heavy body and less energy after a long day of play!","gu":"થાકેલું! રમત રમ્યા પછી ભારે શરીર અને ઓછી ઉર્જાનો અનુભવ!","hi":"थका हुआ! खेलने के बाद भारी शरीर और कम ऊर्जा का अहसास!"}'::jsonb,
  '{"en":"We feel tired when our muscles have worked hard during play or school. Resting, drinking water, or sleeping helps recharge our batteries!","gu":"શાળા કે રમતમાં સખત મહેનત કરવાથી આપણું શરીર થાકી જાય છે. આરામ કરવાથી અને પાણી પીવાથી આપણી ઉર્જા ફરી પાછી આવે છે.","hi":"खेलने या पढ़ाई में मेहनत करने के बाद हम थका हुआ महसूस करते हैं। आराम करने और पानी पीने से हमारी ऊर्जा वापस लौट आती है।"}'::jsonb,
  '{"en":"Did you know? Even while we sleep, our brain is busy sorting our memories from the day and preparing us for the next morning!","gu":"શું તમે જાણો છો? આપણે જ્યારે ઊંઘતા હોઈએ છીએ ત્યારે પણ આપણું મગજ આખા દિવસની યાદોને ગોઠવવા માટે સતત સક્રિય હોય છે!","hi":"क्या आपको पता है? सोते समय भी हमारा दिमाग दिन भर की यादों को व्यवस्थित करने और हमें अगली सुबह के लिए तैयार करने में व्यस्त रहता है!"}'::jsonb,
  'memory',
  true,
  4
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  hex_code = EXCLUDED.hex_code,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.emotions (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'sad',
  (SELECT id FROM categories WHERE category_key = 'emotions' LIMIT 1),
  '{"en":"Sad","gu":"ઉદાસ","hi":"उदास"}'::jsonb,
  'assets/images/emotions/sad.png',
  '#64B5F6',
  '{"en":"Sad! A downturned mouth and soft tears — it is okay to cry!","gu":"ઉદાસ! નમેલો ચહેરો અને આંખમાં આંસુ — રડવું એ સામાન્ય બાબત છે!","hi":"उदास! लटका हुआ चेहरा और आंखों में आंसू — रोना बिल्कुल सामान्य है!"}'::jsonb,
  '{"en":"We feel sad when we lose something we love or say goodbye. Crying is a healthy way for our body to release sadness and start feeling better.","gu":"જ્યારે આપણે આપણી કોઈ વાહલી વસ્તુ ગુમાવીએ અથવા વિદાય લઈએ ત્યારે ઉદાસ થઈએ છીએ. રડવાથી આપણા મનનો ભાર હળવો થાય છે.","hi":"जब हम अपनी कोई पसंदीदा चीज़ खो देते हैं, तो हम उदास महसूस करते हैं। रोने से मन का बोझ हल्का होता है और हम बेहतर महसूस करते हैं।"}'::jsonb,
  '{"en":"Did you know? Tears contain natural chemical triggers that act as a built-in soothing medicine for your body to calm down after crying!","gu":"શું તમે જાણો છો? આંસુમાં એવા કુદરતી તત્વો હોય છે જે રડ્યા પછી આપણા શરીરને અને મનને શાંત કરવામાં મદદ કરે છે!","hi":"क्या आपको पता है? आंसुओं में ऐसे प्राकृतिक रसायन होते हैं जो रोने के बाद हमारे शरीर और मन को शांत करने में मदद करते हैं!"}'::jsonb,
  'memory',
  true,
  5
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  hex_code = EXCLUDED.hex_code,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.emotions (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'laughing',
  (SELECT id FROM categories WHERE category_key = 'emotions' LIMIT 1),
  '{"en":"Laughing","gu":"હસવું","hi":"हंसना"}'::jsonb,
  'assets/images/emotions/laughing.png',
  '#4DB6AC',
  '{"en":"Laughing! A big giggle and a bubbly sound of absolute fun!","gu":"હસવું! એક મોટો ખડખડાટ હાસ્ય અને આનંદદાયક અવાજ!","hi":"हंसना! एक जोर की हंसी और मस्ती भरी खिलखिलाहट!"}'::jsonb,
  '{"en":"We laugh when we hear a funny joke, get tickled, or play silly games. Laughing releases happy chemicals in your brain that make you feel amazing!","gu":"જ્યારે આપણે કોઈ રમુજી જોક્સ સાંભળીએ, ગલીપચી થાય ત્યારે હસીએ છીએ. હસવાથી આપણા મગજમાં એવા તત્વો મુક્ત થાય છે જે આપણને ખૂબ જ આનંદ આપે છે.","hi":"जब हम कोई मजेदार चुटकुला सुनते हैं या कोई खेल खेलते हैं, तो हम हंसते हैं। हंसने से हमारे दिमाग में खुशी के रसायन बनते हैं।"}'::jsonb,
  '{"en":"Did you know? Laughing is like exercise! A good hearty laugh exercises your stomach muscles and helps bring lots of fresh air into your body!","gu":"શું તમે જાણો છો? હસવું એ એક વ્યાયામ જેવું છે! ખડખડાટ હસવાથી પેટના સ્નાયુઓની કસરત થાય છે અને શરીરમાં તાજી હવા ભરાય છે.","hi":"क्या आपको पता है? हंसना एक कसरत की तरह है! खुलकर हंसने से पेट की मांसपेशियों का व्यायाम होता है और शरीर में ताजी हवा आती है!"}'::jsonb,
  'memory',
  true,
  6
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  hex_code = EXCLUDED.hex_code,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.emotions (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'scared',
  (SELECT id FROM categories WHERE category_key = 'emotions' LIMIT 1),
  '{"en":"Scared","gu":"ડરેલું","hi":"डरा हुआ"}'::jsonb,
  'assets/images/emotions/scared.png',
  '#9575CD',
  '{"en":"Scared! A fast heart and wide eyes when something feels unsafe!","gu":"ડરેલું! જ્યારે કોઈ વસ્તુ અસુરક્ષિત લાગે ત્યારે ઝડપી ધબકારા અને મોટી આંખો!","hi":"डरा हुआ! जब कुछ असुरक्षित लगे तो तेज धड़कन और बड़ी आंखें!"}'::jsonb,
  '{"en":"We feel scared of dark rooms, loud noises, or new situations. Being scared is your body''s alarm system warning you to be extra careful and safe.","gu":"જ્યારે અંધારા ઓરડા કે મોટા અવાજોથી ડર લાગે ત્યારે તે આપણી સુરક્ષા માટેની કુદરતી ચેતવણી સિસ્ટમ છે જે આપણને સાવધ રાખે છે.","hi":"अंधेरे या तेज आवाजों से डरना स्वाभाविक है। डर हमारे शरीर का एक अलार्म सिस्टम है जो हमें सावधान रहने के लिए सचेत करता है।"}'::jsonb,
  '{"en":"Did you know? Animals get scared too! Some animals like cats puff up their fur to look bigger and scare away whatever is frightening them!","gu":"શું તમે જાણો છો? પ્રાણીઓ પણ ડરે છે! બિલાડી જેવા પ્રાણીઓ ડરના કારણે પોતાના શરીરના વાળ ફુલાવીને મોટા દેખાવા પ્રયત્ન કરે છે.","hi":"क्या आपको पता है? जानवर भी डरते हैं! बिल्ली जैसे जानवर डरने पर अपने बालों को फुला लेते हैं ताकि वे बड़े दिखें और दुश्मन को डरा सकें!"}'::jsonb,
  'memory',
  true,
  7
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  hex_code = EXCLUDED.hex_code,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.emotions (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'curious',
  (SELECT id FROM categories WHERE category_key = 'emotions' LIMIT 1),
  '{"en":"Curious","gu":"જિજ્ઞાસુ","hi":"जिज्ञासु"}'::jsonb,
  'assets/images/emotions/curious.png',
  '#4DD0E1',
  '{"en":"Curious! Asking questions and exploring to learn how things work!","gu":"જિજ્ઞાસુ! પ્રશ્નો પૂછવા અને દુનિયાની વસ્તુઓ કેવી રીતે બને છે તે જાણવું!","hi":"जिज्ञासु! सवाल पूछना और नई चीजों को जानने की इच्छा रखना!"}'::jsonb,
  '{"en":"We feel curious when we see a strange bug, a new toy, or want to know why the sky is blue. Curiosity is the spark that makes us learn new things!","gu":"જિજ્ઞાસા આપણને નવી વસ્તુઓ શીખવામાં મદદ કરે છે. જ્યારે આપણે કોઈ જીવજંતુ કે રમકડું જોઈએ ત્યારે આપણને પ્રશ્નો થાય છે.","hi":"जब हम कोई नई चीज देखते हैं या सवाल पूछते हैं, तो हम जिज्ञासु होते हैं। जिज्ञासा ही हमें नई चीजें सीखने के लिए प्रेरित करती है!"}'::jsonb,
  '{"en":"Did you know? Cats are famous for being curious, but young children are actually the most curious beings — asking an average of 300 questions a day!","gu":"શું તમે જાણો છો? બાળકો દુનિયાના સૌથી જિજ્ઞાસુ સભ્યો છે, તેઓ દિવસમાં સરેરાશ ૩૦૦ જેટલા પ્રશ્નો પૂછે છે!","hi":"क्या आपको पता है? बच्चे दुनिया में सबसे जिज्ञासु होते हैं — वे दिन भर में औसतन 300 से अधिक सवाल पूछते हैं!"}'::jsonb,
  'memory',
  true,
  8
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  hex_code = EXCLUDED.hex_code,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.emotions (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'calm',
  (SELECT id FROM categories WHERE category_key = 'emotions' LIMIT 1),
  '{"en":"Calm","gu":"શાંત","hi":"शांत"}'::jsonb,
  'assets/images/emotions/calm.png',
  '#81C784',
  '{"en":"Calm! A peaceful mind and slow, steady breathing.","gu":"શાંત! એક એકદમ શાંત મન અને સ્થિર શ્વાસોશ્વાસનો અનુભવ.","hi":"शांत! एक शांतिपूर्ण मन और स्थिर सांसें।"}'::jsonb,
  '{"en":"We feel calm when we sit quietly, read a nice book, or listen to soft music. Feeling calm helps our body rest and think clearly.","gu":"જ્યારે આપણે શાંતિથી બેસીને પુસ્તક વાંચીએ કે હળવું સંગીત સાંભળીએ ત્યારે આપણે શાંત હોઈએ છીએ. તેનાથી મગજ યોગ્ય રીતે વિચારી શકે છે.","hi":"जब हम शांति से बैठते हैं, किताब पढ़ते हैं या संगीत सुनते हैं, तो हम शांत महसूस करते हैं। इससे हमें स्पष्ट रूप से सोचने में मदद मिलती है।"}'::jsonb,
  '{"en":"Did you know? Taking just three deep, slow breaths can instantly tell your brain to stop stressing and help your entire body feel calm!","gu":"શું તમે જાણો છો? માત્ર ત્રણ ઊંડા અને ધીમા શ્વાસ લેવાથી પણ આપણા મગજનો તણાવ ઓછો થાય છે અને આખા શરીરને શાંતિ મળે છે.","hi":"क्या आपको पता है? केवल तीन गहरी और धीमी सांसें लेने से भी हमारे दिमाग का तनाव कम हो जाता है और पूरे शरीर को शांति मिलती है!"}'::jsonb,
  'memory',
  true,
  9
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  hex_code = EXCLUDED.hex_code,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.emotions (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'surprised',
  (SELECT id FROM categories WHERE category_key = 'emotions' LIMIT 1),
  '{"en":"Surprised","gu":"આશ્ચર્યચકિત","hi":"आश्चर्यकृत"}'::jsonb,
  'assets/images/emotions/surprised.png',
  '#BA68C8',
  '{"en":"Surprised! Wide-open mouth and raised eyebrows — wow!","gu":"આશ્ચર્યચકિત! મોટો ખુલ્લો ચહેરો અને ઊંચી આંખો — અરે વાહ!","hi":"आश्चर्यचकित! खुला हुआ मुंह और उठी हुई भौंहें — अरे वाह!"}'::jsonb,
  '{"en":"We feel surprised when something unexpected happens, like a surprise birthday party or a magic trick. It makes our eyes wide so we can see what happened!","gu":"જ્યારે અણધારી કોઈ ઘટના બને જેમ કે અચાનક બર્થડે પાર્ટી કે કોઈ જાદુઈ રમત, ત્યારે આપણે આશ્ચર્યચકિત થઈએ છીએ.","hi":"जब कुछ ऐसा होता है जिसकी हमें उम्मीद नहीं होती, जैसे अचानक जन्मदिन की पार्टी, तो हम आश्चर्यचकित महसूस करते हैं।"}'::jsonb,
  '{"en":"Did you know? A surprise facial expression lasts less than a second on your face — it is the shortest emotion we show!","gu":"શું તમે જાણો છો? આશ્ચર્યનો ભાવ આપણા ચહેરા પર એક સેકન્ડ કરતાં પણ ઓછા સમય માટે રહે છે, તે સૌથી ટૂંકો ભાવ છે!","hi":"क्या आपको पता है? आश्चर्य का भाव हमारे चेहरे पर एक सेकंड से भी कम समय तक रहता है, यह सबसे छोटा भाव है जो हम दिखाते हैं!"}'::jsonb,
  'memory',
  true,
  10
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  hex_code = EXCLUDED.hex_code,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.emotions (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'proud',
  (SELECT id FROM categories WHERE category_key = 'emotions' LIMIT 1),
  '{"en":"Proud","gu":"ગર્વ","hi":"गर्व"}'::jsonb,
  'assets/images/emotions/proud.png',
  '#AED581',
  '{"en":"Proud! Standing tall with a big smile after doing something great!","gu":"ગર્વ! કોઈ મહાન કાર્ય કર્યા પછી સન્માનભેર મધુર સ્મિત આપવું!","hi":"गर्व! कुछ अच्छा करने के बाद सम्मान से सिर ऊंचा रखना और मुस्कुराना!"}'::jsonb,
  '{"en":"We feel proud when we build a tall tower, learn to ride a bike, or help someone. It is a warm feeling of being happy with your own hard work!","gu":"જ્યારે આપણે કોઈ સુંદર ચિત્ર બનાવીએ, સાયકલ ચલાવતા શીખીએ કે કોઈની મદદ કરીએ ત્યારે આપણને ગર્વ થાય છે. આ આપણી મહેનતનું ફળ છે.","hi":"जब हम कोई चित्र बनाते हैं, साइकिल चलाना सीखते हैं या किसी की मदद करते हैं, तो हमें गर्व महसूस होता है। यह हमारी मेहनत की खुशी है।"}'::jsonb,
  '{"en":"Did you know? Feeling proud makes your body naturally stand straighter and chest lift up — showing everyone you did a fantastic job!","gu":"શું તમે જાણો છો? ગર્વનો અનુભવ આપણી પીઠને સીધી કરે છે અને આપણો ઉત્સાહ વધારે છે જેથી બધાને ખબર પડે કે આપણે ખૂબ સરસ કામ કર્યું છે!","hi":"क्या आपको पता है? गर्व महसूस करने पर हमारा शरीर अपने आप सीधा हो जाता है और हमारा आत्मविश्वास बढ़ जाता है!"}'::jsonb,
  'memory',
  true,
  11
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  hex_code = EXCLUDED.hex_code,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.emotions (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'confused',
  (SELECT id FROM categories WHERE category_key = 'emotions' LIMIT 1),
  '{"en":"Confused","gu":"મુંઝવણ","hi":"उलझन"}'::jsonb,
  'assets/images/emotions/confused.png',
  '#D4E157',
  '{"en":"Confused! Scratching your head and thinking hard when things don''t make sense!","gu":"મુંઝવણ! જ્યારે કોઈ વસ્તુ સમજાતી ન હોય ત્યારે માથું ખંજવાળવું અને વિચારવું!","hi":"उलझन! जब कोई बात समझ में न आए तो सिर खुजलाना और गहराई से सोचना!"}'::jsonb,
  '{"en":"We feel confused when a puzzle is tricky or instructions are hard to follow. Being confused is just the first step before your brain figures it out!","gu":"જ્યારે કોઈ કોયડો મુશ્કેલ હોય કે ગણિતનો પ્રશ્ન અઘરો હોય ત્યારે મુંઝવણ થાય છે. મુંઝવણ એ નવું શીખવાની શરૂઆત છે.","hi":"जब कोई पहेली कठिन हो या निर्देश समझ में न आएं, तो उलझन होती. उलझन किसी नई बात को समझने की शुरुआत होती है।"}'::jsonb,
  '{"en":"Did you know? When you are confused, your brain forms new pathways as it works hard to solve the problem, making you smarter!","gu":"શું તમે જાણો છો? મુંઝવણના સમયે આપણું મગજ સક્રિય બનીને નવા ઉકેલો શોધે છે, જેનાથી આપણી બુદ્ધિનો વિકાસ થાય છે!","hi":"क्या आपको पता है? उलझन के समय हमारा दिमाग सक्रिय होकर नए रास्ते खोजता है, जिससे हमारी सोचने की क्षमता बढ़ती है!"}'::jsonb,
  'memory',
  true,
  12
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  hex_code = EXCLUDED.hex_code,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.emotions (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'shy',
  (SELECT id FROM categories WHERE category_key = 'emotions' LIMIT 1),
  '{"en":"Shy","gu":"શરમાળ","hi":"शर्मीला"}'::jsonb,
  'assets/images/emotions/shy.png',
  '#FF8A80',
  '{"en":"Shy! Hiding behind a smile or looking down when meeting new people.","gu":"શરમાળ! નવા લોકોને મળતી વખતે શરમાવું અને સ્મિત પાછળ સંતાવું.","hi":"शर्मीला! नए लोगों से मिलते समय शर्माना और नजरें नीचे करना।"}'::jsonb,
  '{"en":"We feel shy when we are in a big crowd, or speak in front of others. It takes a little time to feel comfortable, and that is completely okay!","gu":"જ્યારે આપણે નવા વાતાવરણમાં કે ઘણા લોકો વચ્ચે હોઈએ ત્યારે શરમ અનુભવીએ છીએ. થોડો સમય આપવાથી આપણે સહજ થઈ જઈએ છીએ.","hi":"जब हम नए माहौल में या कई लोगों के बीच होते हैं, तो हम शर्माते हैं। थोड़ा समय मिलने पर हम धीरे-धीरे सहज महसूस करने लगते हैं।"}'::jsonb,
  '{"en":"Did you know? Shyness can make your cheeks turn pink or red — this is called blushing, and it happens because your heart sends more warm blood to your face!","gu":"શું તમે જાણો છો? શરમના કારણે આપણા ગાલ લાલ થઈ જાય છે, જેને શરમાવું (blushing) કહે છે. ચહેરો લાલ થવાથી આવું થાય છે.","hi":"क्या आपको पता है? शर्म के कारण हमारे गाल लाल हो जाते हैं, जिसे शर्माना (blushing) कहते हैं। ऐसा चेहरे पर खून का प्रवाह बढ़ने से होता है!"}'::jsonb,
  'memory',
  true,
  13
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  hex_code = EXCLUDED.hex_code,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.emotions (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'worried',
  (SELECT id FROM categories WHERE category_key = 'emotions' LIMIT 1),
  '{"en":"Worried","gu":"ચિંતિત","hi":"चिंतित"}'::jsonb,
  'assets/images/emotions/worried.png',
  '#90A4AE',
  '{"en":"Worried! A little flutter in your tummy when you are unsure about what might happen.","gu":"ચિંતિત! જ્યારે કોઈ બાબતમાં અનિશ્ચિતતા હોય ત્યારે પેટમાં મૂંઝવણ થવી.","hi":"चिंतित! जब किसी बात को लेकर मन में घबराहट हो।"}'::jsonb,
  '{"en":"We feel worried about tests, being late, or someone getting hurt. Talking to a parent or teacher is the best way to share worries and make them disappear!","gu":"પરીક્ષા આપતી વખતે કે મોડા પડતી વખતે ચિંતા થવી સામાન્ય છે. આપણી ચિંતા માતાપિતા કે શિક્ષક સાથે શેર કરવાથી તે દૂર થાય છે.","hi":"परीक्षा या किसी काम में देरी होने पर चिंता होना स्वाभाविक है। अपनी चिंता माता-पिता या शिक्षक से साझा करने पर मन हल्का हो जाता है।"}'::jsonb,
  '{"en":"Did you know? Sharing a worry with someone you love actually halves the heavy feeling in your tummy — talking about it works like magic!","gu":"શું તમે જાણો છો? આપણી ચિંતા કોઈ પ્રિય વ્યક્તિ સાથે શેર કરવાથી મન અડધું હળવું થઈ જાય છે, તે જાદુની જેમ કામ કરે છે!","hi":"क्या आपको पता है? अपनी चिंता किसी अपने से साझा करने से मन का बोझ आधा हो जाता है, यह जादू की तरह काम करता है!"}'::jsonb,
  'memory',
  true,
  14
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  hex_code = EXCLUDED.hex_code,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.emotions (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'excited',
  (SELECT id FROM categories WHERE category_key = 'emotions' LIMIT 1),
  '{"en":"Excited","gu":"ઉત્સાહિત","hi":"उत्साहित"}'::jsonb,
  'assets/images/emotions/excited.png',
  '#FF8F00',
  '{"en":"Excited! Jumping up and down with lots of happy energy!","gu":"ઉત્સાહિત! ખુશી અને ખૂબ જ ઉર્જા સાથે કુદાકૂદ કરવી!","hi":"उत्साहित! खुशी और ढेर सारी ऊर्जा के साथ उछल-कूद करना!"}'::jsonb,
  '{"en":"We feel excited when we go to a theme park, play with a new puppy, or go on holiday. It makes us want to run, laugh, and bounce around!","gu":"જ્યારે આપણે ફરવા જઈએ કે નવું રમકડું મળે ત્યારે આપણે ઉત્સાહિત હોઈએ છીએ. આપણને દોડવાનું અને હસવાનું મન થાય છે.","hi":"जब हम कहीं घूमने जाते हैं या नया खिलौना मिलता है, तो हम उत्साहित होते हैं। इससे हमारा दौड़ने और हंसने का मन करता है!"}'::jsonb,
  '{"en":"Did you know? Excitement triggers the release of adrenaline, making your heart pump faster and giving you temporary super-energy to jump high!","gu":"શું તમે જાણો છો? ઉત્સાહ દરમિયાન આપણા શરીરમાં એડ્રેનાલિન મુક્ત થાય છે, જે હૃદયના ધબકારા વધારે છે અને આપણને ઉર્જા પૂરી પાડે છે!","hi":"क्या आपको पता है? उत्साह के समय हमारे शरीर में एड्रेनालाईन हार्मोन बनता है, जिससे हमारे दिल की धड़कन बढ़ जाती है और हमें ऊर्जा मिलती है!"}'::jsonb,
  'memory',
  true,
  15
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  hex_code = EXCLUDED.hex_code,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.emotions (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'embarrassed',
  (SELECT id FROM categories WHERE category_key = 'emotions' LIMIT 1),
  '{"en":"Embarrassed","gu":"છોભીલા પડવું","hi":"शर्मिंदा"}'::jsonb,
  'assets/images/emotions/embarrassed.png',
  '#FFAB91',
  '{"en":"Embarrassed! Wishing you could hide when you make a little mistake in front of others.","gu":"છોભીલા પડવું! જ્યારે બધાની સામે કોઈ ભૂલ થઈ જાય ત્યારે સંતાઈ જવાનું મન થવું.","hi":"शर्मिंदा! जब सबके सामने कोई छोटी सी गलती हो जाए और छिपाने का मन करे।"}'::jsonb,
  '{"en":"We feel embarrassed if we trip, spill milk, or say the wrong word. Mistakes happen to everyone, and laughing it off is the best way to feel better!","gu":"જ્યારે આપણાથી પાણી ઢોળાઈ જાય કે ક્યાંક ભટકાઈ જવાય ત્યારે આપણે છોભીલા પડીએ છીએ. ભૂલો બધાથી થાય છે, હસી કાઢવું એ જ ઉત્તમ ઉપાય છે.","hi":"जब हमसे कोई छोटी गलती होती है, तो हमें संकोच होता है। गलतियां सबसे होती हैं, इसलिए उन पर मुस्कुराकर आगे बढ़ना ही सबसे अच्छा है!"}'::jsonb,
  '{"en":"Did you know? Humans are the only animals in the world who show embarrassment by blushing (turning red) — no other creature does this!","gu":"શું તમે જાણો છો? દુનિયામાં માત્ર મનુષ્યો જ શરમના કારણે ચહેરો લાલ કરે છે, અન્ય કોઈ પ્રાણી આવું કરતું નથી!","hi":"क्या आपको पता है? इंसान ही एकमात्र ऐसा प्राणी है जो शर्मिंदा होने पर अपना चेहरा लाल कर लेता है, कोई और जानवर ऐसा नहीं करता!"}'::jsonb,
  'memory',
  true,
  16
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  hex_code = EXCLUDED.hex_code,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.emotions (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'crying',
  (SELECT id FROM categories WHERE category_key = 'emotions' LIMIT 1),
  '{"en":"Crying","gu":"રડવું","hi":"रोना"}'::jsonb,
  'assets/images/emotions/crying.png',
  '#90CAF9',
  '{"en":"Crying! Wet tears falling down your cheeks to show you are hurt or very sad.","gu":"રડવું! ગાલ પરથી વહેતા આંસુ જે દર્શાવે છે કે તમે દુઃખી છો.","hi":"रोना! गालों पर बहते आंसू जो दिखाते हैं कि आप बहुत दुखी हैं।"}'::jsonb,
  '{"en":"We cry when we fall and scrape our knee, or when our feelings are hurt. Crying is a helpful way for our body to wash away sad feelings.","gu":"જ્યારે આપણે પડી જઈએ કે વાગે ત્યારે અથવા મન દુઃખી થાય ત્યારે રડીએ છીએ. રડવાથી આપણા મનની ઉદાસી દૂર થાય છે.","hi":"जब हमें चोट लगती है या हमारा मन दुखी होता है, तो हम रोते हैं। रोने से हमारे मन की उदासी बाहर आ जाती है।"}'::jsonb,
  '{"en":"Did you know? Crying actually triggers your brain to release endorphins, which are natural painkillers that help your body feel better and calmer!","gu":"શું તમે જાણો છો? રડવાથી આપણા મગજમાં એવા તત્વો મુક્ત થાય છે જે કુદરતી પેઇનકિલર તરીકે કામ કરે છે અને મનને શાંત કરે છે!","hi":"क्या आपको पता है? रोने से हमारे मस्तिष्क में एंडोर्फिन बनता है, जो प्राकृतिक पेनकिलर की तरह काम करता है और दर्द को कम करता है!"}'::jsonb,
  'memory',
  true,
  17
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  hex_code = EXCLUDED.hex_code,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.emotions (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'bored',
  (SELECT id FROM categories WHERE category_key = 'emotions' LIMIT 1),
  '{"en":"Bored","gu":"કંટાળો","hi":"उबाऊ"}'::jsonb,
  'assets/images/emotions/bored.png',
  '#B0BEC5',
  '{"en":"Bored! A sigh and heavy head when there seems to be nothing fun to do.","gu":"કંટાળો! એક ઊંડો નિસાસો અને ભારે માથું જ્યારે કોઈ રમત રમવાની ન હોય.","hi":"उबाऊ! एक गहरी सांस और भारीपन जब करने के लिए कुछ मजेदार न हो।"}'::jsonb,
  '{"en":"We feel bored when we have to wait in line, or don''t know what to play. Boredom is great because it challenges your brain to invent new, creative games!","gu":"જ્યારે આપણે કોઈ લાઇનમાં રાહ જોવાની હોય કે શું રમવું તે ખબર ન હોય ત્યારે કંટાળો આવે છે. કંટાળો આપણને નવી રમતો શોધવા પ્રેરિત કરે છે.","hi":"जब हमें इंतजार करना पड़ता है या खेलने के लिए कुछ नहीं होता, तो बोरियत होती है। बोरियत हमें नई और रचनात्मक चीजें सोचने में मदद करती है!"}'::jsonb,
  '{"en":"Did you know? Being bored actually sparks creativity! Some of the world''s greatest inventions and stories were created because someone was bored and started dreaming!","gu":"શું તમે જાણો છો? કંટાળો જિજ્ઞાસા અને નવી શોધખોળને જન્મ આપે છે! દુનિયાની શ્રેષ્ઠ વાર્તાઓ કંટાળાના સમયમાં જ શોધાઈ હતી.","hi":"क्या आपको पता है? बोरियत से रचनात्मकता बढ़ती है! दुनिया के कई महान आविष्कार और कहानियां तब बनीं जब लोग बोर हो रहे थे और सोचने लगे!"}'::jsonb,
  'memory',
  true,
  18
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  hex_code = EXCLUDED.hex_code,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.emotions (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'sick',
  (SELECT id FROM categories WHERE category_key = 'emotions' LIMIT 1),
  '{"en":"Sick","gu":"બીમાર","hi":"बीमार"}'::jsonb,
  'assets/images/emotions/sick.png',
  '#D7CCC8',
  '{"en":"Sick! A warm forehead and low energy, wishing for rest and a warm soup.","gu":"બીમાર! ગરમ કપાળ અને ઓછી ઉર્જા, આરામ અને ગરમ સૂપની ઈચ્છા.","hi":"बीमार! गर्म माथा और कम ऊर्जा, आराम और सूप की चाह।"}'::jsonb,
  '{"en":"We feel sick when tiny germs enter our body. Resting in bed, sleeping, and drinking soup helps our immune system fight the germs and make us strong again!","gu":"જ્યારે જંતુઓ આપણા શરીરમાં પ્રવેશે ત્યારે આપણે બીમાર પડીએ છીએ. આરામ કરવાથી આપણી રોગપ્રતિકારક શક્તિ મજબૂત બને છે અને આપણે જલ્દી સાજા થઈએ છીએ.","hi":"जब कीटाणु हमारे शरीर में प्रवेश करते हैं, तो हम बीमार हो जाते हैं। आराम करने और गर्म चीजें खाने-पीने से हमारा शरीर कीटाणुओं से लड़ता है।"}'::jsonb,
  '{"en":"Did you know? Sleeping is the best medicine when you are sick! Your body produces extra immune cells during sleep to fight off the germs much faster!","gu":"શું તમે જાણો છો? બીમારીમાં ઊંઘ એ સૌથી શ્રેષ્ઠ દવા છે! ઊંઘ દરમિયાન આપણું શરીર જંતુઓ સામે લડવા માટે વધુ કોષો ઉત્પન્ન કરે છે.","hi":"क्या आपको पता है? बीमार होने पर सोना सबसे अच्छी दवा है! सोते समय हमारा शरीर कीटाणुओं से लड़ने के लिए अधिक प्रतिरोधी कोशिकाओं का निर्माण करता है!"}'::jsonb,
  'memory',
  true,
  19
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  hex_code = EXCLUDED.hex_code,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.emotions (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'loving',
  (SELECT id FROM categories WHERE category_key = 'emotions' LIMIT 1),
  '{"en":"Loving","gu":"પ્રેમાળ","hi":"प्यारा"}'::jsonb,
  'assets/images/emotions/loving.png',
  '#F8BBD0',
  '{"en":"Loving! A warm, cozy hug that shows how much you care about someone.","gu":"પ્રેમાળ! એક ગૂંથેલો અને નરમ આલિંગન જે દર્શાવે છે કે તમે કોઈની કેટલી કાળજી રાખો છો.","hi":"प्यारा! एक गर्मजोशी भरा गले लगाना जो दिखाता है कि आप किसी की कितनी परवाह करते हैं।"}'::jsonb,
  '{"en":"We feel loving when we share our toys, help our parents, or hug our friends. Love is a warm feeling that grows bigger the more you share it!","gu":"જ્યારે આપણે રમકડાં શેર કરીએ, માતાપિતાને મદદ કરીએ કે મિત્રને ગળે લગાવીએ ત્યારે પ્રેમનો ભાવ જાગે છે. પ્રેમ વહેંચવાથી વધે છે.","hi":"जब हम अपने खिलौने साझा करते हैं, माता-पिता की मदद करते हैं, तो हम प्यार महसूस करते हैं। प्यार एक ऐसी भावना है जो बांटने से बढ़ती है!"}'::jsonb,
  '{"en":"Did you know? Giving someone a warm hug for just 20 seconds releases a chemical called oxytocin, which instantly makes you both feel happier and closer!","gu":"શું તમે જાણો છો? માત્ર ૨૦ સેકન્ડ માટે કોઈને આલિંગન આપવાથી શરીરમાં ઓક્સિટોસિન મુક્ત થાય છે, જે બંનેને ખુશ કરે છે!","hi":"क्या आपको पता है? किसी को केवल 20 सेकंड के लिए गले लगाने से शरीर में ऑक्सीटोसिन निकलता है, जो दोनों को तुरंत खुश कर देता है!"}'::jsonb,
  'memory',
  true,
  20
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  hex_code = EXCLUDED.hex_code,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;
