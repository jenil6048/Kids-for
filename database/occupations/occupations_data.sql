-- 1. Update cover image paths in categories table
UPDATE categories
SET image_path = 'https://pdhqylmzjdkvdbnezwhq.supabase.co/storage/v1/object/public/assets/covers/occupations.png'
WHERE category_key = 'occupations';


-- 2. Create occupations table and index

CREATE TABLE IF NOT EXISTS public.occupations (
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
  constraint occupations_pkey primary key (id),
  constraint occupations_topic_key_key unique (topic_key),
  constraint occupations_category_id_fkey foreign KEY (category_id) references categories (id) on delete CASCADE
) TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS idx_occupations_topic_key on public.occupations using btree (topic_key) TABLESPACE pg_default;

ALTER TABLE public.occupations DISABLE ROW LEVEL SECURITY;

GRANT ALL ON public.occupations TO anon;
GRANT ALL ON public.occupations TO authenticated;
GRANT ALL ON public.occupations TO service_role;


-- 3. Populate occupations table with data

INSERT INTO public.occupations
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES
(
  'doctor',
  (SELECT id FROM categories WHERE category_key = 'occupations' LIMIT 1),
  '{"en": "Doctor", "gu": "ડોક્ટર", "hi": "डॉक्टर"}'::jsonb,
  '/assets/images/occupation/doctor.png',
  '{"en": "Doctor! Doctors are kind people who help us stay healthy and feel better when we are sick.", "gu": "ડોક્ટર! ડોક્ટર દયાળુ વ્યક્તિઓ છે જે આપણને સ્વસ્થ રહેવામાં અને બીમાર હોય ત્યારે સાજા થવામાં મદદ કરે છે.", "hi": "डॉक्टर! डॉक्टर दयालु लोग होते हैं जो हमें स्वस्थ रहने और बीमार होने पर बेहतर महसूस करने में मदद करते हैं।"}'::jsonb,
  '{"en": "Doctors work in hospitals and clinics. They use tools like stethoscopes to listen to our heartbeats!", "gu": "ડોક્ટરો હોસ્પિટલ અને ક્લિનિકમાં કામ કરે છે. તેઓ આપણા હૃદયના ધબકારા સાંભળવા માટે સ્ટેથોસ્કોપ જેવા સાધનોનો ઉપયોગ કરે છે!", "hi": "डॉक्टर अस्पतालों और क्लीनिकों में काम करते हैं। वे हमारे दिल की धड़कन सुनने के लिए स्टेथोस्कोप जैसे उपकरणों का उपयोग करते हैं!"}'::jsonb,
  '{"en": "Did you know? Doctors study for many years to learn everything about how the human body works!", "gu": "શું તમે જાણો છો? માનવ શરીર કેવી રીતે કાર્ય કરે છે તે બધું શીખવા માટે ડોક્ટરો ઘણા વર્ષો સુધી અભ્યાસ કરે છે!", "hi": "क्या आपको पता है? मानव शरीर कैसे काम करता है, इसके बारे में सब कुछ सीखने के लिए डॉक्टर कई सालों तक पढ़ाई करते हैं!"}'::jsonb,
  'memory',
  true,
  1
),
(
  'teacher',
  (SELECT id FROM categories WHERE category_key = 'occupations' LIMIT 1),
  '{"en": "Teacher", "gu": "શિક્ષક", "hi": "शिक्षक"}'::jsonb,
  '/assets/images/occupation/teacher.png',
  '{"en": "Teacher! Teachers help us learn new things like reading, writing, and math in school.", "gu": "શિક્ષક! શિક્ષકો આપણને શાળામાં વાંચન, લેખન અને ગણિત જેવી નવી વસ્તુઓ શીખવામાં મદદ કરે છે.", "hi": "शिक्षक! शिक्षक हमें स्कूल में पढ़ना, लिखना और गणित जैसी नई चीज़ें सीखने में मदद करते हैं।"}'::jsonb,
  '{"en": "Teachers use books, boards, and fun activities to make learning exciting for their students every day.", "gu": "શિક્ષકો દરરોજ તેમના વિદ્યાર્થીઓ માટે શિક્ષણને રોમાંચક બનાવવા માટે પુસ્તકો, બોર્ડ અને મનોરંજક પ્રવૃત્તિઓનો ઉપયોગ કરે છે.", "hi": "शिक्षक अपने छात्रों के लिए हर दिन सीखने को रोमांचक बनाने के लिए किताबों, बोर्डों और मजेदार गतिविधियों का उपयोग करते हैं।"}'::jsonb,
  '{"en": "Did you know? Teachers don''t just teach subjects; they also help us learn how to be kind and helpful!", "gu": "શું તમે જાણો છો? શિક્ષકો ફક્ત વિષયો જ નથી ભણાવતા; તેઓ આપણને દયાળુ અને મદદરૂપ કેવી રીતે બનવું તે શીખવામાં પણ મદદ કરે છે!", "hi": "क्या आपको पता है? शिक्षक केवल विषय ही नहीं पढ़ाते; वे हमें दयालु और मददगार बनना सीखने में भी मदद करते हैं!"}'::jsonb,
  'memory',
  true,
  2
),
(
  'firefighter',
  (SELECT id FROM categories WHERE category_key = 'occupations' LIMIT 1),
  '{"en": "Firefighter", "gu": "અગ્નિશામક (ફાયર ફાઈટર)", "hi": "दमकलकर्मी"}'::jsonb,
  '/assets/images/occupation/firefighter.png',
  '{"en": "Firefighter! Firefighters are brave heroes who put out fires and rescue people and animals.", "gu": "ફાયર ફાઈટર! ફાયર ફાઈટર એ બહાદુર હીરો છે જે આગ ઓલવે છે અને લોકો અને પ્રાણીઓને બચાવે છે.", "hi": "दमकलकर्मी! दमकलकर्मी बहादुर नायक होते हैं जो आग बुझाते हैं और लोगों और जानवरों को बचाते हैं।"}'::jsonb,
  '{"en": "They wear special heavy suits and helmets for protection, and drive big red fire trucks with loud sirens!", "gu": "તેઓ રક્ષણ માટે ખાસ ભારે કપડાં અને હેલ્મેટ પહેરે છે અને મોટા લાલ ફાયર ટ્રક ચલાવે છે!", "hi": "वे सुरक्षा के लिए विशेष भारी सूट और हेलमेट पहनते हैं, और तेज़ सायरन वाली बड़ी लाल दमकल गाड़ियाँ चलाते हैं!"}'::jsonb,
  '{"en": "Did you know? Firefighters use long hoses that can spray a lot of water very quickly to cool down hot fires!", "gu": "શું તમે જાણો છો? ફાયર ફાઈટર લાંબી પાઇપનો ઉપયોગ કરે છે જે ગરમ આગને ઠંડી પાડવા માટે ખૂબ જ ઝડપથી ઘણું પાણી છાંટી શકે છે!", "hi": "क्या आपको पता है? दमकलकर्मी लंबी नली का उपयोग करते हैं जो भीषण आग को बुझाने के लिए बहुत तेज़ी से बहुत सारा पानी छिड़क सकती है!"}'::jsonb,
  'memory',
  true,
  3
),
(
  'police_officer',
  (SELECT id FROM categories WHERE category_key = 'occupations' LIMIT 1),
  '{"en": "Police Officer", "gu": "પોલીસ અધિકારી", "hi": "पुलिस अधिकारी"}'::jsonb,
  '/assets/images/occupation/police_officer.png',
  '{"en": "Police Officer! Police officers help keep our neighborhoods safe and follow the rules.", "gu": "પોલીસ અધિકારી! પોલીસ અધિકારીઓ આપણા પડોશને સુરક્ષિત રાખવામાં અને નિયમોનું પાલન કરવામાં મદદ કરે છે.", "hi": "पुलिस अधिकारी! पुलिस अधिकारी हमारे पड़ोस को सुरक्षित रखने और नियमों का पालन करने में मदद करते हैं।"}'::jsonb,
  '{"en": "They drive police cars, help people in trouble, and can be found at police stations or patrolling the streets.", "gu": "તેઓ પોલીસ કાર ચલાવે છે, મુશ્કેલીમાં રહેલા લોકોને મદદ કરે છે અને પોલીસ સ્ટેશનોમાં અથવા શેરીઓમાં જોવા મળે છે.", "hi": "वे पुलिस की गाड़ियाँ चलाते हैं, मुसीबत में पड़े लोगों की मदद करते हैं, और पुलिस स्टेशनों या सड़कों पर गश्त करते हुए पाए जाते हैं।"}'::jsonb,
  '{"en": "Did you know? Police officers wear shiny badges that show they are there to help and protect everyone!", "gu": "શું તમે જાણો છો? પોલીસ અધિકારીઓ ચમકતા બેજ પહેરે છે જે દર્શાવે છે કે તેઓ દરેકને મદદ કરવા અને સુરક્ષિત રાખવા માટે છે!", "hi": "क्या आपको पता है? पुलिस अधिकारी चमकदार बैज पहनते हैं जो दिखाते हैं कि वे हर किसी की मदद करने और सुरक्षा के लिए वहां हैं!"}'::jsonb,
  'memory',
  true,
  4
),
(
  'pilot',
  (SELECT id FROM categories WHERE category_key = 'occupations' LIMIT 1),
  '{"en": "Pilot", "gu": "પાયલોટ", "hi": "पायलट"}'::jsonb,
  '/assets/images/occupation/pilot.png',
  '{"en": "Pilot! Pilots are skilled people who fly airplanes and helicopters high in the sky.", "gu": "પાયલોટ! પાયલોટ એ કુશળ વ્યક્તિઓ છે જે આકાશમાં ઊંચા વિમાન અને હેલિકોપ્ટર ઉડાવે છે.", "hi": "पायलट! पायलट कुशल लोग होते हैं जो आसमान में ऊंचे हवाई जहाज और हेलीकॉप्टर उड़ाते हैं।"}'::jsonb,
  '{"en": "Pilots sit in a cockpit and use many buttons and controls to travel across the world very fast.", "gu": "પાયલોટ કોકપિટમાં બેસે છે અને સમગ્ર વિશ્વમાં ખૂબ જ ઝડપથી મુસાફરી કરવા માટે ઘણા બટનો અને નિયંત્રણોનો ઉપયોગ કરે છે.", "hi": "पायलट कॉकपिट में बैठते हैं और दुनिया भर में बहुत तेज़ी से यात्रा करने के लिए कई बटनों और नियंत्रणों का उपयोग करते हैं।"}'::jsonb,
  '{"en": "Did you know? Pilots have to talk to air traffic controllers on the ground to make sure it''s safe to fly!", "gu": "શું તમે જાણો છો? પાયલોટ્સે જમીન પરના એર ટ્રાફિક કંટ્રોલર્સ સાથે વાત કરવી પડે છે જેથી ઉડાન સુરક્ષિત રહે!", "hi": "क्या आपको पता है? पायलटों को जमीन पर हवाई यातायात नियंत्रकों से बात करनी पड़ती है ताकि यह सुनिश्चित हो सके कि उड़ान भरना सुरक्षित है!"}'::jsonb,
  'memory',
  true,
  5
),
(
  'artist',
  (SELECT id FROM categories WHERE category_key = 'occupations' LIMIT 1),
  '{"en": "Artist", "gu": "કલાકાર", "hi": "कलाकार"}'::jsonb,
  '/assets/images/occupation/artist.png',
  '{"en": "Artist! Artists use their imagination to create beautiful paintings, drawings, and sculptures.", "gu": "કલાકાર! કલાકારો સુંદર પેઇન્ટિંગ્સ, રેખાંકનો અને શિલ્પો બનાવવા માટે તેમની કલ્પનાશક્તિનો ઉપયોગ કરે છે.", "hi": "कलाकार! कलाकार सुंदर पेंटिंग, चित्र और मूर्तियां बनाने के लिए अपनी कल्पना का उपयोग करते हैं।"}'::jsonb,
  '{"en": "Artists use brushes, pencils, and lots of bright colors to show how they feel and what they see in the world.", "gu": "કલાકારો તેઓ કેવું અનુભવે છે અને વિશ્વમાં તેઓ શું જુએ છે તે દર્શાવવા માટે પીંછીઓ, પેન્સિલો અને ઘણા તેજસ્વી રંગોનો ઉપયોગ કરે છે.", "hi": "कलाकार अपनी भावनाओं और दुनिया में जो देखते हैं उसे दिखाने के लिए ब्रश, पेंसिल और कई चमकीले रंगों का उपयोग करते हैं।"}'::jsonb,
  '{"en": "Did you know? Some famous artists'' paintings are hundreds of years old and are kept in museums for everyone to see!", "gu": "શું તમે જાણો છો? કેટલાક પ્રખ્યાત કલાકારોના પેઇન્ટિંગ્સ સેંકડો વર્ષ જૂના છે અને દરેકને જોવા માટે મ્યુઝિયમમાં રાખવામાં આવ્યા છે!", "hi": "क्या आपको पता है? कुछ प्रसिद्ध कलाकारों की पेंटिंग सैकड़ों साल पुरानी हैं और उन्हें संग्रहालयों में सभी के देखने के लिए रखा गया है!"}'::jsonb,
  'memory',
  true,
  6
),
(
  'farmer',
  (SELECT id FROM categories WHERE category_key = 'occupations' LIMIT 1),
  '{"en": "Farmer", "gu": "ખેડૂત", "hi": "किसान"}'::jsonb,
  '/assets/images/occupation/farmer.png',
  '{"en": "Farmer! Farmers work hard on farms to grow the food we eat, like fruits, vegetables, and grains.", "gu": "ખેડૂત! ખેડૂતો આપણે જે ખોરાક ખાઈએ છીએ, જેમ કે ફળો, શાકભાજી અને અનાજ ઉગાડવા માટે ખેતરોમાં સખત મહેનત કરે છે.", "hi": "किसान! किसान फल, सब्जियां और अनाज जैसे भोजन उगाने के लिए खेतों में कड़ी मेहनत करते हैं।"}'::jsonb,
  '{"en": "Farmers also take care of animals like cows, chickens, and sheep. They use tractors to help with their work!", "gu": "ખેડૂતો ગાય, મરઘી અને ઘેટા જેવા પ્રાણીઓની પણ સંભાળ રાખે છે. તેઓ તેમના કામમાં મદદ કરવા માટે ટ્રેક્ટરનો ઉપયોગ કરે છે!", "hi": "किसान गाय, मुर्गी और भेड़ जैसे जानवरों की भी देखभाल करते हैं। वे अपने काम में मदद के लिए ट्रैक्टर का इस्तेमाल करते हैं!"}'::jsonb,
  '{"en": "Did you know? Without farmers, we wouldn''t have many of the yummy foods we enjoy every day!", "gu": "શું તમે જાણો છો? ખેડૂતો વિના, આપણે દરરોજ માણીએ છીએ તેવા ઘણા સ્વાદિષ્ટ ખોરાક આપણી પાસે ન હોત!", "hi": "क्या आपको पता है? किसानों के बिना, हमारे पास वे कई स्वादिष्ट भोजन नहीं होते जिनका हम हर दिन आनंद लेते हैं!"}'::jsonb,
  'memory',
  true,
  7
),
(
  'chef',
  (SELECT id FROM categories WHERE category_key = 'occupations' LIMIT 1),
  '{"en": "Chef", "gu": "રસોઈયા (શેફ)", "hi": "शेफ"}'::jsonb,
  '/assets/images/occupation/chef.png',
  '{"en": "Chef! Chefs are experts at cooking delicious meals in restaurants and hotels.", "gu": "શેફ! શેફ રેસ્ટોરન્ટ અને હોટલમાં સ્વાદિષ્ટ ભોજન બનાવવામાં નિષ્ણાત હોય છે.", "hi": "शेफ! शेफ रेस्तरां और होटलों में स्वादिष्ट भोजन पकाने में विशेषज्ञ होते हैं।"}'::jsonb,
  '{"en": "They wear tall white hats and use many kitchen tools to prepare yummy food for people to enjoy.", "gu": "તેઓ ઊંચી સફેદ ટોપી પહેરે છે અને લોકો માણી શકે તેવું સ્વાદિષ્ટ ભોજન તૈયાર કરવા માટે રસોડાના ઘણા સાધનોનો ઉપયોગ કરે છે.", "hi": "वे लंबी सफेद टोपी पहनते हैं और लोगों के आनंद लेने के लिए स्वादिष्ट भोजन तैयार करने के लिए रसोई के कई उपकरणों का उपयोग करते हैं।"}'::jsonb,
  '{"en": "Did you know? A chef''s tall white hat is called a ''toque'', and it has 100 folds to show they know 100 ways to cook an egg!", "gu": "શું તમે જાણો છો? શેફની ઊંચી સફેદ ટોપીને ''ટોક'' કહેવામાં આવે છે, અને તેમાં ૧૦૦ ગડી હોય છે જે દર્શાવે છે કે તેઓ ઈંડું રાંધવાની ૧૦૦ રીતો જાણે છે!", "hi": "क्या आपको पता है? शेफ की लंबी सफेद टोपी को ''टोक'' कहा जाता है, और इसमें 100 तह होती हैं जो यह दर्शाती हैं कि वे अंडे पकाने के 100 तरीके जानते हैं!"}'::jsonb,
  'memory',
  true,
  8
),
(
  'astronaut',
  (SELECT id FROM categories WHERE category_key = 'occupations' LIMIT 1),
  '{"en": "Astronaut", "gu": "અવકાશયાત્રી", "hi": "अंतरिक्ष यात्री"}'::jsonb,
  '/assets/images/occupation/astronaut.png',
  '{"en": "Astronaut! Astronauts are brave explorers who travel into outer space in rockets and spaceships.", "gu": "અવકાશયાત્રી! અવકાશયાત્રીઓ બહાદુર સંશોધકો છે જે રોકેટ અને અવકાશયાનમાં બાહ્ય અવકાશમાં મુસાફરી કરે છે.", "hi": "अंतरिक्ष यात्री! अंतरिक्ष यात्री बहादुर खोजकर्ता होते हैं जो रॉकेट और अंतरिक्ष यान में बाहरी अंतरिक्ष की यात्रा करते हैं।"}'::jsonb,
  '{"en": "They wear special spacesuits to stay safe and study the moon, planets, and stars high above the Earth.", "gu": "તેઓ સુરક્ષિત રહેવા માટે ખાસ સ્પેસસૂટ પહેરે છે અને પૃથ્વીની ઉપર ચંદ્ર, ગ્રહો અને તારાઓનો અભ્યાસ કરે છે.", "hi": "वे सुरक्षित रहने के लिए विशेष स्पेससूट पहनते हैं और पृथ्वी से बहुत ऊपर चंद्रमा, ग्रहों और सितारों का अध्ययन करते हैं।"}'::jsonb,
  '{"en": "Did you know? In space, there is no gravity, so astronauts can float around like they are flying!", "gu": "શું તમે જાણો છો? અવકાશમાં ગુરુત્વાકર્ષણ નથી, તેથી અવકાશયાત્રીઓ ઉડતા હોય તેમ આસપાસ તરી શકે છે!", "hi": "क्या आपको पता है? अंतरिक्ष में गुरुत्वाकर्षण नहीं होता है, इसलिए अंतरिक्ष यात्री उड़ने की तरह इधर-उधर तैर सकते हैं!"}'::jsonb,
  'memory',
  true,
  9
),
(
  'scientist',
  (SELECT id FROM categories WHERE category_key = 'occupations' LIMIT 1),
  '{"en": "Scientist", "gu": "વૈજ્ઞાનિક", "hi": "वैज्ञानिक"}'::jsonb,
  '/assets/images/occupation/scientist.png',
  '{"en": "Scientist! Scientists are curious people who study how the world works and make new discoveries.", "gu": "વૈજ્ઞાનિક! વૈજ્ઞાનિકો જિજ્ઞાસુ લોકો છે જેઓ વિશ્વ કેવી રીતે કાર્ય કરે છે તેનો અભ્યાસ કરે છે અને નવી શોધો કરે છે.", "hi": "वैज्ञानिक! वैज्ञानिक जिज्ञासु लोग होते हैं जो यह अध्ययन करते हैं कि दुनिया कैसे काम करती है और नई खोजें करते हैं।"}'::jsonb,
  '{"en": "Scientists do experiments in laboratories using microscopes and test tubes to learn about plants, animals, and space.", "gu": "વૈજ્ઞાનિકો છોડ, પ્રાણીઓ અને અવકાશ વિશે જાણવા માટે માઇક્રોસ્કોપ અને ટેસ્ટ ટ્યુબનો ઉપયોગ કરીને પ્રયોગશાળાઓમાં પ્રયોગો કરે છે.", "hi": "वैज्ञानिक पौधों, जानवरों और अंतरिक्ष के बारे में जानने के लिए सूक्ष्मदर्शी और टेस्ट ट्यूब का उपयोग करके प्रयोगशालाओं में प्रयोग करते हैं।"}'::jsonb,
  '{"en": "Did you know? Scientists have helped invent things we use every day, like computers, medicines, and even light bulbs!", "gu": "શું તમે જાણો છો? વૈજ્ઞાનિકોએ કમ્પ્યુટર, દવાઓ અને લાઇટ બલ્બ જેવી રોજબરોજની વસ્તુઓ શોધવામાં મદદ કરી છે!", "hi": "क्या आपको पता है? वैज्ञानिकों ने कंप्यूटर, दवाओं और यहां तक कि लाइट बल्ब जैसी उन चीजों का आविष्कार करने में मदद की है जिनका हम हर दिन उपयोग करते हैं!"}'::jsonb,
  'memory',
  true,
  10
),
(
  'baker',
  (SELECT id FROM categories WHERE category_key = 'occupations' LIMIT 1),
  '{"en": "Baker", "gu": "બેકર", "hi": "बेकर"}'::jsonb,
  '/assets/images/occupation/baker.png',
  '{"en": "Baker! Bakers make yummy bread, cookies, and cakes in a bakery.", "gu": "બેકર! બેકર્સ બેકરીમાં સ્વાદિષ્ટ બ્રેડ, કુકીઝ અને કેક બનાવે છે.", "hi": "बेकर! बेकर बेकरी में स्वादिष्ट ब्रेड, कुकीज़ और केक बनाते हैं।"}'::jsonb,
  '{"en": "They use flour, sugar, and big ovens to bake delicious treats that smell wonderful!", "gu": "તેઓ લોટ, ખાંડ અને મોટા ઓવનનો ઉપયોગ કરીને સ્વાદિષ્ટ વાનગીઓ બનાવે છે જેની સુગંધ અદ્ભુત હોય છે!", "hi": "वे मैदा, चीनी और बड़े ओवन का उपयोग करके स्वादिष्ट चीज़ें बनाते हैं जिनकी खुशबू बहुत अच्छी होती है!"}'::jsonb,
  '{"en": "Did you know? The oldest bakery in the world has been making bread for over 800 years!", "gu": "શું તમે જાણો છો? વિશ્વની સૌથી જૂની બેકરી ૮૦૦ થી વધુ વર્ષોથી બ્રેડ બનાવી રહી છે!", "hi": "क्या आपको पता है? दुनिया की सबसे पुरानी बेकरी 800 से अधिक वर्षों से ब्रेड बना रही है!"}'::jsonb,
  'memory',
  true,
  11
),
(
  'nurse',
  (SELECT id FROM categories WHERE category_key = 'occupations' LIMIT 1),
  '{"en": "Nurse", "gu": "નર્સ", "hi": "नर्स"}'::jsonb,
  '/assets/images/occupation/nurse.png',
  '{"en": "Nurse! Nurses take care of sick or injured people to help them get well.", "gu": "નર્સ! નર્સ બીમાર અથવા ઘાયલ લોકોની સંભાળ રાખે છે જેથી તેઓ સાજા થઈ શકે.", "hi": "नर्स! नर्स बीमार या घायल लोगों की देखभाल करती हैं ताकि वे ठीक हो सकें।"}'::jsonb,
  '{"en": "Nurses work with doctors in hospitals. They give medicine, check temperatures, and give kind smiles!", "gu": "નર્સ હોસ્પિટલમાં ડોકટરો સાથે કામ કરે છે. તેઓ દવા આપે છે, તાપમાન તપાસે છે અને માયાળુ સ્મિત આપે છે!", "hi": "नर्स अस्पतालों में डॉक्टरों के साथ काम करती हैं। वे दवा देती हैं, तापमान जाँचती हैं, और प्यारी मुस्कान देती हैं!"}'::jsonb,
  '{"en": "Did you know? Nurses often wear special clothes called ''scrubs'' that are comfortable and easy to clean!", "gu": "શું તમે જાણો છો? નર્સ ઘણીવાર ''સ્ક્રબ્સ'' નામના ખાસ કપડાં પહેરે છે જે આરામદાયક અને સાફ કરવામાં સરળ હોય છે!", "hi": "क्या आपको पता है? नर्स अक्सर ''स्क्रब्स'' नामक विशेष कपड़े पहनती हैं जो आरामदायक और साफ करने में आसान होते हैं!"}'::jsonb,
  'memory',
  true,
  12
),
(
  'dentist',
  (SELECT id FROM categories WHERE category_key = 'occupations' LIMIT 1),
  '{"en": "Dentist", "gu": "દંત ચિકિત્સક", "hi": "दंत चिकित्सक"}'::jsonb,
  '/assets/images/occupation/dentist.png',
  '{"en": "Dentist! Dentists are special doctors who take care of our teeth and gums.", "gu": "દંત ચિકિત્સક! ડેન્ટિસ્ટ ખાસ ડોકટરો છે જે આપણા દાંત અને પેઢાની સંભાળ રાખે છે.", "hi": "दंत चिकित्सक! दंत चिकित्सक विशेष डॉक्टर होते हैं जो हमारे दांतों और मसूड़ों की देखभाल करते हैं।"}'::jsonb,
  '{"en": "They check for cavities and show us how to brush and floss so our smiles stay bright and healthy!", "gu": "તેઓ દાંતના સડાની તપાસ કરે છે અને આપણને બ્રશ અને ફ્લોસ કેવી રીતે કરવું તે શીખવે છે જેથી આપણું સ્મિત તેજસ્વી અને સ્વસ્થ રહે!", "hi": "वे कैविटी की जाँच करते हैं और हमें ब्रश और फ्लॉस करना सिखाते हैं ताकि हमारी मुस्कान चमकती और स्वस्थ रहे!"}'::jsonb,
  '{"en": "Did you know? Just like your fingerprints, your teeth patterns are unique to only you!", "gu": "શું તમે જાણો છો? તમારી ફિંગરપ્રિન્ટ્સની જેમ જ, તમારા દાંતની પેટર્ન પણ ફક્ત તમારા માટે જ અનન્ય છે!", "hi": "क्या आपको पता है? आपकी उंगलियों के निशान की तरह, आपके दांतों का पैटर्न भी केवल आपके लिए ही अनोखा है!"}'::jsonb,
  'memory',
  true,
  13
),
(
  'veterinarian',
  (SELECT id FROM categories WHERE category_key = 'occupations' LIMIT 1),
  '{"en": "Veterinarian", "gu": "પશુચિકિત્સક", "hi": "पशु चिकित्सक"}'::jsonb,
  '/assets/images/occupation/veterinarian.png',
  '{"en": "Veterinarian! Veterinarians, or vets, are doctors who help sick or injured animals.", "gu": "પશુચિકિત્સક! વેટરનરી ડોકટરો એવા ડોકટરો છે જે બીમાર અથવા ઘાયલ પ્રાણીઓને મદદ કરે છે.", "hi": "पशु चिकित्सक! पशु चिकित्सक वे डॉक्टर होते हैं जो बीमार या घायल जानवरों की मदद करते हैं।"}'::jsonb,
  '{"en": "Vets take care of all kinds of animals, from fluffy kittens and puppies to big farm animals and even lions!", "gu": "વેટરનરી ડોકટરો રુંવાટીદાર બિલાડીના બચ્ચાં અને ગલુડિયાઓથી લઈને ખેતરના મોટા પ્રાણીઓ અને સિંહ સુધીના તમામ પ્રકારના પ્રાણીઓની સંભાળ રાખે છે!", "hi": "पशु चिकित्सक सभी प्रकार के जानवरों की देखभाल करते हैं, छोटे बिल्ली के बच्चों और पिल्लों से लेकर बड़े खेत के जानवरों और यहाँ तक कि शेरों तक!"}'::jsonb,
  '{"en": "Did you know? Some vets even work in zoos or at the ocean to help wild animals stay healthy!", "gu": "શું તમે જાણો છો? કેટલાક પશુચિકિત્સકો જંગલી પ્રાણીઓને સ્વસ્થ રાખવામાં મદદ કરવા માટે પ્રાણી સંગ્રહાલયમાં અથવા સમુદ્રમાં પણ કામ કરે છે!", "hi": "क्या आपको पता है? कुछ पशु चिकित्सक जंगली जानवरों को स्वस्थ रखने में मदद करने के लिए चिड़ियाघर या समुद्र में भी काम करते हैं!"}'::jsonb,
  'memory',
  true,
  14
),
(
  'construction_worker',
  (SELECT id FROM categories WHERE category_key = 'occupations' LIMIT 1),
  '{"en": "Construction Worker", "gu": "બાંધકામ મજૂર", "hi": "निर्माण श्रमिक"}'::jsonb,
  '/assets/images/occupation/construction_worker.png',
  '{"en": "Construction Worker! Construction workers build houses, schools, and big skyscrapers.", "gu": "બાંધકામ મજૂર! બાંધકામ કામદારો ઘરો, શાળાઓ અને ગગનચુંબી ઈમારતો બનાવે છે.", "hi": "निर्माण श्रमिक! निर्माण श्रमिक घर, स्कूल और बड़ी गगनचुंबी इमारतें बनाते हैं।"}'::jsonb,
  '{"en": "They wear hard hats for safety and use tools like hammers, drills, and big cranes to do their work.", "gu": "તેઓ સુરક્ષા માટે હાર્ડ હેટ (હેલ્મેટ) પહેરે છે અને હથોડી, ડ્રીલ અને મોટી ક્રેન જેવા સાધનોનો ઉપયોગ કરે છે.", "hi": "वे सुरक्षा के लिए सख्त टोपी पहनते हैं और हथौड़े, ड्रिल और बड़ी क्रेन जैसे औजारों का उपयोग करते हैं।"}'::jsonb,
  '{"en": "Did you know? Construction workers use blue-colored drawings called ''blueprints'' to know exactly where everything goes!", "gu": "શું તમે જાણો છો? બાંધકામ કામદારો બધું ક્યાં જશે તે ચોક્કસ રીતે જાણવા માટે ''બ્લુપ્રિન્ટ'' નામના વાદળી રંગના રેખાંકનોનો ઉપયોગ કરે છે!", "hi": "क्या आपको पता है? निर्माण श्रमिक ''ब्लूप्रिंट'' नामक नीले रंग के नक्शों का उपयोग करते हैं ताकि उन्हें पता चल सके कि कौन सी चीज़ कहाँ बनेगी!"}'::jsonb,
  'memory',
  true,
  15
),
(
  'mail_carrier',
  (SELECT id FROM categories WHERE category_key = 'occupations' LIMIT 1),
  '{"en": "Mail Carrier", "gu": "ટપાલી", "hi": "डाकिया"}'::jsonb,
  '/assets/images/occupation/mail_carrier.png',
  '{"en": "Mail Carrier! Mail carriers deliver letters, cards, and packages to our homes every day.", "gu": "ટપાલી! ટપાલી દરરોજ આપણા ઘરે પત્રો, કાર્ડ્સ અને પાર્સલ પહોંચાડે છે.", "hi": "डाकिया! डाकिया हर दिन हमारे घरों में पत्र, कार्ड और पार्सल पहुँचाते हैं।"}'::jsonb,
  '{"en": "They walk or drive a mail truck to bring us special messages from friends and family, no matter the weather!", "gu": "ભલે ગમે તેવું હવામાન હોય, તેઓ મિત્રો અને પરિવારના ખાસ સંદેશાઓ લાવવા માટે ચાલીને અથવા ટપાલની ટ્રક ચલાવીને આવે છે!", "hi": "मौसम कैसा भी हो, वे दोस्तों और परिवार के विशेष संदेश लाने के लिए पैदल चलते हैं या डाक ट्रक चलाते हैं!"}'::jsonb,
  '{"en": "Did you know? In some places long ago, mail carriers used horses or even pigeons to deliver messages!", "gu": "શું તમે જાણો છો? ઘણા સમય પહેલા કેટલીક જગ્યાએ ટપાલીઓ સંદેશા પહોંચાડવા માટે ઘોડા કે કબૂતરોનો ઉપયોગ કરતા હતા!", "hi": "क्या आपको पता है? बहुत पहले कुछ जगहों पर, डाकिये संदेश पहुँचाने के लिए घोड़ों या कबूतरों का इस्तेमाल करते थे!"}'::jsonb,
  'memory',
  true,
  16
),
(
  'gardener',
  (SELECT id FROM categories WHERE category_key = 'occupations' LIMIT 1),
  '{"en": "Gardener", "gu": "માળી", "hi": "माली"}'::jsonb,
  '/assets/images/occupation/gardener.png',
  '{"en": "Gardener! Gardeners take care of plants, flowers, and trees to make gardens look beautiful.", "gu": "માળી! માળી બગીચાને સુંદર બનાવવા માટે છોડ, ફૂલો અને વૃક્ષોની સંભાળ રાખે છે.", "hi": "माली! माली बगीचों को सुंदर बनाने के लिए पौधों, फूलों और पेड़ों की देखभाल करते हैं।"}'::jsonb,
  '{"en": "They plant seeds, pull weeds, and water the garden so everything stays green and healthy.", "gu": "તેઓ બીજ વાવે છે, નકામું ઘાસ કાઢે છે અને બગીચાને પાણી આપે છે જેથી બધું લીલું અને સ્વસ્થ રહે.", "hi": "वे बीज बोते हैं, खरपतवार निकालते हैं और बगीचे को पानी देते हैं ताकि सब कुछ हरा-भरा और स्वस्थ रहे।"}'::jsonb,
  '{"en": "Did you know? Some gardeners grow vegetables and fruits that we can pick and eat right from the garden!", "gu": "શું તમે જાણો છો? કેટલાક માળીઓ શાકભાજી અને ફળો ઉગાડે છે જે આપણે બગીચામાંથી સીધા તોડીને ખાઈ શકીએ છીએ!", "hi": "क्या आपको पता है? कुछ माली सब्जियां और फल उगाते हैं जिन्हें हम सीधे बगीचे से तोड़कर खा सकते हैं!"}'::jsonb,
  'memory',
  true,
  17
),
(
  'mechanic',
  (SELECT id FROM categories WHERE category_key = 'occupations' LIMIT 1),
  '{"en": "Mechanic", "gu": "મિકેનિક", "hi": "मैकेनिक"}'::jsonb,
  '/assets/images/occupation/mechanic.png',
  '{"en": "Mechanic! Mechanics are experts who fix cars, trucks, and other machines when they break.", "gu": "મિકેનિક! મિકેનિક્સ એવા નિષ્ણાતો છે જે કાર, ટ્રક અને અન્ય મશીનો જ્યારે બગડે ત્યારે તેને ઠીક કરે છે.", "hi": "मैकेनिक! मैकेनिक वे विशेषज्ञ होते हैं जो कारों, ट्रकों और अन्य मशीनों के खराब होने पर उन्हें ठीक करते हैं।"}'::jsonb,
  '{"en": "They use wrenches and tools to fix engines and change tires in a garage to keep us driving safely.", "gu": "તેઓ આપણને સુરક્ષિત રીતે ડ્રાઇવિંગ કરવા માટે એન્જિનને ઠીક કરવા અને ગેરેજમાં ટાયર બદલવા માટે રેન્ચ અને સાધનોનો ઉપયોગ કરે છે.", "hi": "वे हमें सुरक्षित रूप से चलाने के लिए इंजन को ठीक करने और गैरेज में टायर बदलने के लिए रिंच और औजारों का उपयोग करते हैं।"}'::jsonb,
  '{"en": "Did you know? Mechanics have to learn a lot about how computers work because modern cars use them to run!", "gu": "શું તમે જાણો છો? મિકેનિક્સને કોમ્પ્યુટર કેવી રીતે કામ કરે છે તે વિશે ઘણું શીખવું પડે છે કારણ કે આધુનિક કાર ચલાવવા માટે તેનો ઉપયોગ થાય છે!", "hi": "क्या आपको पता है? मैकेनिकों को कंप्यूटर के काम करने के तरीके के बारे में बहुत कुछ सीखना पड़ता है क्योंकि आधुनिक कारें उनका उपयोग करती हैं!"}'::jsonb,
  'memory',
  true,
  18
),
(
  'musician',
  (SELECT id FROM categories WHERE category_key = 'occupations' LIMIT 1),
  '{"en": "Musician", "gu": "સંગીતકાર", "hi": "संगीतकार"}'::jsonb,
  '/assets/images/occupation/musician.png',
  '{"en": "Musician! Musicians are talented people who play instruments or sing beautiful songs.", "gu": "સંગીતકાર! સંગીતકારો પ્રતિભાશાળી લોકો છે જેઓ વાદ્યો વગાડે છે અથવા સુંદર ગીતો ગાય છે.", "hi": "संगीतकार! संगीतकार वे प्रतिभाशाली लोग होते हैं जो वाद्ययंत्र बजाते हैं या सुंदर गीत गाते हैं।"}'::jsonb,
  '{"en": "They play instruments like the piano, guitar, or drums to create music that makes us want to dance!", "gu": "તેઓ પિયાનો, ગિટાર અથવા ડ્રમ જેવા વાદ્યો વગાડીને સંગીત બનાવે છે જે આપણને નૃત્ય કરવા પ્રેરે છે!", "hi": "वे पियानो, गिटार या ड्रम जैसे वाद्ययंत्र बजाते हैं और ऐसा संगीत बनाते हैं जिससे हमारा नाचने का मन करता है!"}'::jsonb,
  '{"en": "Did you know? Playing an instrument can actually make your brain stronger and smarter!", "gu": "શું તમે જાણો છો? વાદ્ય વગાડવાથી વાસ્તવમાં તમારું મગજ વધુ મજબૂત અને સ્માર્ટ બની શકે છે!", "hi": "क्या आपको पता है? वाद्ययंत्र बजाना वास्तव में आपके मस्तिष्क को अधिक मजबूत और तेज बना सकता है!"}'::jsonb,
  'memory',
  true,
  19
),
(
  'dancer',
  (SELECT id FROM categories WHERE category_key = 'occupations' LIMIT 1),
  '{"en": "Dancer", "gu": "નૃત્યકાર", "hi": "नर्तक"}'::jsonb,
  '/assets/images/occupation/dancer.png',
  '{"en": "Dancer! Dancers move their bodies to the rhythm of music to express feelings or tell stories.", "gu": "નૃત્યકાર! નર્તકો લાગણીઓ વ્યક્ત કરવા અથવા વાર્તાઓ કહેવા માટે સંગીતના લય પર તેમના શરીરને હલાવે છે.", "hi": "नर्तक! नर्तक भावनाओं को व्यक्त करने या कहानियां सुनाने के लिए संगीत की लय पर अपने शरीर को हिलाते हैं।"}'::jsonb,
  '{"en": "There are many kinds of dance, like ballet, hip-hop, and folk dance. They practice hard to be graceful!", "gu": "નૃત્યના ઘણા પ્રકારો છે, જેમ કે બેલે, હિપ-હોપ અને લોકનૃત્ય. તેઓ લવચીક બનવા માટે સખત પ્રેક્ટિસ કરે છે!", "hi": "नृत्य के कई प्रकार हैं, जैसे बैले, हिप-हॉप और लोक नृत्य। वे सुंदर दिखने के लिए कड़ी मेहनत करते हैं!"}'::jsonb,
  '{"en": "Did you know? Dancing is a great way to stay healthy and strong while having lots of fun!", "gu": "શું તમે જાણો છો? નૃત્ય એ ખૂબ જ મજા માણવાની સાથે સ્વસ્થ અને મજબૂત રહેવાની એક સરસ રીત છે!", "hi": "क्या आपको पता है? नृत्य बहुत मजे करने के साथ-साथ स्वस्थ और मजबूत रहने का एक शानदार तरीका है!"}'::jsonb,
  'memory',
  true,
  20
),
(
  'photographer',
  (SELECT id FROM categories WHERE category_key = 'occupations' LIMIT 1),
  '{"en": "Photographer", "gu": "ફોટોગ્રાફર", "hi": "फोटोग्राफर"}'::jsonb,
  '/assets/images/occupation/photographer.png',
  '{"en": "Photographer! Photographers use cameras to capture beautiful pictures and special moments.", "gu": "ફોટોગ્રાફર! ફોટોગ્રાફરો સુંદર ચિત્રો અને ખાસ પળોને કેપ્ચર કરવા માટે કેમેરાનો ઉપયોગ કરે છે.", "hi": "फोटोग्राफर! फोटोग्राफर सुंदर चित्रों और विशेष क्षणों को कैद करने के लिए कैमरों का उपयोग करते हैं।"}'::jsonb,
  '{"en": "They take photos of people, nature, and animals so we can remember fun times forever.", "gu": "તેઓ લોકો, પ્રકૃતિ અને પ્રાણીઓના ફોટા લે છે જેથી આપણે મજાના સમયને કાયમ યાદ રાખી શકીએ.", "hi": "वे लोगों, प्रकृति और जानवरों की तस्वीरें लेते हैं ताकि हम मजेदार समय को हमेशा याद रख सकें।"}'::jsonb,
  '{"en": "Did you know? The first photograph ever taken took eight hours to capture! Now, it takes less than a second!", "gu": "શું તમે જાણો છો? લેવામાં આવેલ પ્રથમ ફોટોગ્રાફને કેપ્ચર કરવામાં આઠ કલાક લાગ્યા હતા! હવે, તેમાં એક સેકન્ડથી પણ ઓછો સમય લાગે છે!", "hi": "क्या आपको पता है? पहली तस्वीर खींचने में आठ घंटे लगे थे! अब, इसमें एक सेकंड से भी कम समय लगता है!"}'::jsonb,
  'memory',
  true,
  21
),
(
  'athlete',
  (SELECT id FROM categories WHERE category_key = 'occupations' LIMIT 1),
  '{"en": "Athlete", "gu": "રમતવીર", "hi": "एथलीट"}'::jsonb,
  '/assets/images/occupation/athlete.png',
  '{"en": "Athlete! Athletes are people who are very good at playing sports and games.", "gu": "રમતવીર! રમતવીરો એવા લોકો છે જેઓ રમતગમતમાં ખૂબ જ કુશળ હોય છે.", "hi": "एथलीट! एथलीट वे लोग होते हैं जो खेलकूद में बहुत अच्छे होते हैं।"}'::jsonb,
  '{"en": "They run, jump, or play team sports like soccer or basketball. They exercise every day to stay strong!", "gu": "તેઓ દોડે છે, કૂદે છે અથવા ફૂટબોલ કે બાસ્કેટબોલ જેવી ટીમ સ્પોર્ટ્સ રમે છે. તેઓ મજબૂત રહેવા માટે દરરોજ કસરત કરે છે!", "hi": "वे दौड़ते हैं, कूदते हैं, या फुटबॉल या बास्केटबॉल जैसे टीम खेल खेलते हैं। वे मजबूत रहने के लिए हर दिन व्यायाम करते हैं!"}'::jsonb,
  '{"en": "Did you know? Some athletes go to the Olympics to compete with other players from all around the world!", "gu": "શું તમે જાણો છો? કેટલાક રમતવીરો વિશ્વભરના અન્ય ખેલાડીઓ સાથે સ્પર્ધા કરવા ઓલિમ્પિકમાં જાય છે!", "hi": "क्या आपको पता है? कुछ एथलीट दुनिया भर के अन्य खिलाड़ियों के साथ प्रतिस्पर्धा करने के लिए ओलंपिक में जाते हैं!"}'::jsonb,
  'memory',
  true,
  22
),
(
  'detective',
  (SELECT id FROM categories WHERE category_key = 'occupations' LIMIT 1),
  '{"en": "Detective", "gu": "ડિટેક્ટિવ", "hi": "जासूस"}'::jsonb,
  '/assets/images/occupation/detective.png',
  '{"en": "Detective! Detectives are clever people who solve mysteries and find clues.", "gu": "ડિટેક્ટિવ! ડિટેક્ટિવ્સ એવા ચતુર લોકો છે જે રહસ્યો ઉકેલે છે અને કડીઓ શોધે છે.", "hi": "जासूस! जासूस वे चतुर लोग होते हैं जो रहस्यों को सुलझाते हैं और सुराग ढूंढते हैं।"}'::jsonb,
  '{"en": "They use magnifying glasses and look for footprints to figure out what happened and help keep people safe.", "gu": "તેઓ શું થયું તે શોધવા અને લોકોને સુરક્ષિત રાખવામાં મદદ કરવા માટે બિલોરી કાચનો ઉપયોગ કરે છે અને પગના નિશાન શોધે છે.", "hi": "वे मैग्नीफाइंग ग्लास का उपयोग करते हैं और यह पता लगाने के लिए पैरों के निशान ढूंढते हैं कि क्या हुआ था और लोगों को सुरक्षित रखने में मदद करते हैं।"}'::jsonb,
  '{"en": "Did you know? Detectives use fingerprints because no two people in the world have the exact same ones!", "gu": "શું તમે જાણો છો? ડિટેક્ટિવ્સ ફિંગરપ્રિન્ટ્સનો ઉપયોગ કરે છે કારણ કે વિશ્વમાં કોઈ પણ બે વ્યક્તિ પાસે એક સરખી ફિંગરપ્રિન્ટ્સ નથી હોતી!", "hi": "क्या आपको पता है? जासूस उंगलियों के निशान का उपयोग करते हैं क्योंकि दुनिया में किन्हीं भी दो लोगों के निशान एक जैसे नहीं होते!"}'::jsonb,
  'memory',
  true,
  23
),
(
  'librarian',
  (SELECT id FROM categories WHERE category_key = 'occupations' LIMIT 1),
  '{"en": "Librarian", "gu": "ગ્રંથપાલ", "hi": "पुस्तकालयाध्यक्ष"}'::jsonb,
  '/assets/images/occupation/librarian.png',
  '{"en": "Librarian! Librarians work in libraries and help us find amazing books to read.", "gu": "ગ્રંથપાલ! ગ્રંથપાલો પુસ્તકાલયોમાં કામ કરે છે અને આપણને વાંચવા માટે અદ્ભુત પુસ્તકો શોધવામાં મદદ કરે છે.", "hi": "पुस्तकालयाध्यक्ष! पुस्तकालयाध्यक्ष पुस्तकालयों में काम करते हैं और हमें पढ़ने के लिए बेहतरीन किताबें खोजने में मदद करते हैं।"}'::jsonb,
  '{"en": "They organize thousands of books and tell fun stories during storytime for kids to enjoy!", "gu": "તેઓ હજારો પુસ્તકોનું આયોજન કરે છે અને બાળકો માણી શકે તે માટે વાર્તાના સમય દરમિયાન મજાની વાર્તાઓ કહે છે!", "hi": "वे हजारों किताबों को व्यवस्थित करते हैं और बच्चों के आनंद लेने के लिए कहानियों के समय मजेदार कहानियां सुनाते हैं!"}'::jsonb,
  '{"en": "Did you know? Some big libraries have millions of books, and even movies and music you can borrow!", "gu": "શું તમે જાણો છો? કેટલીક મોટી લાયબ્રેરીઓમાં લાખો પુસ્તકો હોય છે, અને તે પણ ફિલ્મો અને સંગીત જે તમે ઉછીના લઈ શકો છો!", "hi": "क्या आपको पता है? कुछ बड़े पुस्तकालयों में लाखों किताबें होती हैं, और यहाँ तक कि फ़िल्में और संगीत भी जिन्हें आप उधार ले सकते हैं!"}'::jsonb,
  'memory',
  true,
  24
),
(
  'architect',
  (SELECT id FROM categories WHERE category_key = 'occupations' LIMIT 1),
  '{"en": "Architect", "gu": "આર્કિટેક્ટ", "hi": "वास्तुकार"}'::jsonb,
  '/assets/images/occupation/architect.png',
  '{"en": "Architect! Architects are people who design how buildings and houses should look.", "gu": "આર્કિટેક્ટ! આર્કિટેક્ટ્સ એવા લોકો છે જે ઇમારતો and ઘરો કેવા દેખાવા જોઈએ તેની ડિઝાઇન કરે છે.", "hi": "वास्तुकार! वास्तुकार वे लोग होते हैं जो यह डिजाइन करते हैं कि इमारतों और घरों को कैसा दिखना चाहिए।"}'::jsonb,
  '{"en": "They draw plans on paper or computers to make sure buildings are strong, safe, and beautiful to live in.", "gu": "ઇમારતો મજબૂત, સુરક્ષિત અને રહેવા માટે સુંદર છે તેની ખાતરી કરવા માટે તેઓ કાગળ અથવા કોમ્પ્યુટર પર પ્લાન દોરે છે.", "hi": "वे यह सुनिश्चित करने के लिए कागज या कंप्यूटर पर नक्शे बनाते हैं कि इमारतें मजबूत, सुरक्षित और रहने में सुंदर हों।"}'::jsonb,
  '{"en": "Did you know? Architects also design fun places like parks, playgrounds, and even stadiums!", "gu": "શું તમે જાણો છો? આર્કિટેક્ટ્સ ઉદ્યાનો, રમતના મેદાનો અને સ્ટેડિયમ જેવી મનોરંજક જગ્યાઓ પણ ડિઝાઇન કરે છે!", "hi": "क्या आपको पता है? वास्तुकार पार्क, खेल के मैदान और यहाँ तक कि स्टेडियम जैसी मजेदार जगहों को भी डिजाइन करते हैं!"}'::jsonb,
  'memory',
  true,
  25
),
(
  'judge',
  (SELECT id FROM categories WHERE category_key = 'occupations' LIMIT 1),
  '{"en": "Judge", "gu": "ન્યાયાધીશ", "hi": "न्यायाधीश"}'::jsonb,
  '/assets/images/occupation/judge.png',
  '{"en": "Judge! Judges are fair people who help follow the rules and make important decisions in court.", "gu": "ન્યાયાધીશ! જજ એ ન્યાયી લોકો છે જે નિયમોનું પાલન કરવામાં મદદ કરે છે અને કોર્ટમાં મહત્વપૂર્ણ નિર્ણયો લે છે.", "hi": "न्यायाधीश! न्यायाधीश निष्पक्ष लोग होते हैं जो नियमों का पालन करने और अदालत में महत्वपूर्ण निर्णय लेने में मदद करते हैं।"}'::jsonb,
  '{"en": "They wear black robes and use a small wooden hammer called a ''gavel'' to keep order during a trial.", "gu": "તેઓ કાળો ઝભ્ભો પહેરે છે અને ટ્રાયલ દરમિયાન વ્યવસ્થા જાળવવા માટે ''ગેવલ'' નામની નાની લાકડાની હથોડીનો ઉપયોગ કરે છે.", "hi": "वे काले कपड़े पहनते हैं और सुनवाई के दौरान व्यवस्था बनाए रखने के लिए ''गेवल'' नामक एक छोटे लकड़ी के हथौड़े का उपयोग करते हैं।"}'::jsonb,
  '{"en": "Did you know? Judges have to study the law for many years to make sure every decision is fair for everyone!", "gu": "શું તમે જાણો છો? દરેક નિર્ણય દરેક માટે ન્યાયી છે તેની ખાતરી કરવા માટે ન્યાયાધીશોએ ઘણા વર્ષો સુધી કાયદાનો અભ્યાસ કરવો પડે છે!", "hi": "क्या आपको पता है? न्यायाधीशों को कई वर्षों तक कानून की पढ़ाई करनी पड़ती है ताकि यह सुनिश्चित हो सके कि हर फैसला सभी के लिए निष्पक्ष हो!"}'::jsonb,
  'memory',
  true,
  26
),
(
  'plumber',
  (SELECT id FROM categories WHERE category_key = 'occupations' LIMIT 1),
  '{"en": "Plumber", "gu": "પ્લમ્બર", "hi": "प्लम्बर"}'::jsonb,
  '/assets/images/occupation/plumber.png',
  '{"en": "Plumber! Plumbers fix pipes so we have clean water to drink and wash our hands.", "gu": "પ્લમ્બર! પ્લમ્બર પાઈપો ફિક્સ કરે છે જેથી આપણી પાસે પીવા અને હાથ ધોવા માટે ચોખ્ખું પાણી હોય.", "hi": "प्लम्बर! प्लम्बर पाइपों को ठीक करते हैं ताकि हमारे पास पीने और हाथ धोने के लिए साफ पानी हो।"}'::jsonb,
  '{"en": "They use tools like wrenches to fix leaky sinks and toilets, and make sure water flows correctly in our homes.", "gu": "તેઓ ટપકતા સિંક અને શૌચાલયને ઠીક કરવા માટે રેન્ચ જેવા સાધનોનો ઉપયોગ કરે છે અને ખાતરી કરે છે કે આપણા ઘરોમાં પાણી યોગ્ય રીતે વહે છે.", "hi": "वे टपकते सिंक और शौचालयों को ठीक करने के लिए रिंच जैसे औजारों का उपयोग करते हैं और सुनिश्चित करते हैं कि हमारे घरों में पानी सही ढंग से बहे।"}'::jsonb,
  '{"en": "Did you know? Plumbers help save a lot of water by fixing leaks that waste many gallons every day!", "gu": "શું તમે જાણો છો? પ્લમ્બર દરરોજ ઘણા ગેલન બગાડતા લીકેજને ઠીક કરીને ઘણું પાણી બચાવવામાં મદદ કરે છે!", "hi": "क्या आपको पता है? प्लम्बर उन लीकेज को ठीक करके बहुत सारा पानी बचाने में मदद करते हैं जो हर दिन कई गैलन पानी बर्बाद करते हैं!"}'::jsonb,
  'memory',
  true,
  27
),
(
  'journalist',
  (SELECT id FROM categories WHERE category_key = 'occupations' LIMIT 1),
  '{"en": "Journalist", "gu": "પત્રકાર", "hi": "पत्रकार"}'::jsonb,
  '/assets/images/occupation/journalist.png',
  '{"en": "Journalist! Journalists find out what is happening in the world and share the news with everyone.", "gu": "પત્રકાર! પત્રકારો વિશ્વમાં શું થઈ રહ્યું છે તે શોધે છે અને સમાચાર દરેક સાથે શેર કરે છે.", "hi": "पत्रकार! पत्रकार यह पता लगाते हैं कि दुनिया में क्या हो रहा है और सभी के साथ खबरें साझा करते हैं।"}'::jsonb,
  '{"en": "They interview people and write stories for newspapers, TV, or the internet so we stay informed.", "gu": "તેઓ લોકોના ઇન્ટરવ્યુ લે છે અને અખબારો, ટીવી અથવા ઇન્ટરનેટ માટે વાર્તાઓ લખે છે જેથી આપણે માહિતગાર રહીએ.", "hi": "वे लोगों का साक्षात्कार लेते हैं और समाचार पत्रों, टीवी या इंटरनेट के लिए खबरें लिखते हैं ताकि हम सूचित रहें।"}'::jsonb,
  '{"en": "Did you know? Journalists travel to many different places, and sometimes even dangerous ones, to get the true story!", "gu": "શું તમે જાણો છો? પત્રકારો સાચી વાર્તા મેળવવા માટે ઘણી અલગ અલગ જગ્યાએ મુસાફરી કરે છે, અને ક્યારેક જોખમી પણ હોય છે!", "hi": "क्या आपको पता है? पत्रकार सच्ची खबर पाने के लिए कई अलग-अलग जगहों, और कभी-कभी खतरनाक जगहों पर भी जाते हैं!"}'::jsonb,
  'memory',
  true,
  28
),
(
  'lifeguard',
  (SELECT id FROM categories WHERE category_key = 'occupations' LIMIT 1),
  '{"en": "Lifeguard", "gu": "લાઇફગાર્ડ", "hi": "लाइफगार्ड"}'::jsonb,
  '/assets/images/occupation/lifeguard.png',
  '{"en": "Lifeguard! Lifeguards are strong swimmers who keep people safe at pools and beaches.", "gu": "લાઇફગાર્ડ! લાઇફગાર્ડ્સ મજબૂત તરવૈયા છે જે પુલ અને દરિયાકિનારા પર લોકોને સુરક્ષિત રાખે છે.", "hi": "लाइफगार्ड! लाइफगार्ड मजबूत तैराक होते हैं जो पूल और समुद्र तटों पर लोगों को सुरक्षित रखते हैं।"}'::jsonb,
  '{"en": "They watch carefully from high chairs and use whistles and rescue tubes to help anyone in trouble in the water.", "gu": "તેઓ ઊંચી ખુરશીઓ પરથી ધ્યાનથી જુએ છે અને પાણીમાં મુશ્કેલીમાં રહેલા કોઈપણને મદદ કરવા માટે વ્હિસલ અને રેસ્ક્યૂ ટ્યુબનો ઉપયોગ કરે છે.", "hi": "वे ऊँची कुर्सियों से ध्यान से देखते हैं और पानी में किसी भी मुसीबत में फँसे व्यक्ति की मदद करने के लिए सीटी और बचाव ट्यूब का उपयोग करते हैं।"}'::jsonb,
  '{"en": "Did you know? Lifeguards have to practice their swimming skills every day to be ready for any emergency!", "gu": "શું તમે જાણો છો? લાઇફગાર્ડ્સે કોઈપણ કટોકટી માટે તૈયાર રહેવા માટે દરરોજ તેમની સ્વિમિંગ કુશળતાનો અભ્યાસ કરવો પડે છે!", "hi": "क्या आपको पता है? लाइफगार्ड्स को किसी भी आपात स्थिति के लिए तैयार रहने के लिए हर दिन अपने तैराकी कौशल का अभ्यास करना पड़ता है!"}'::jsonb,
  'memory',
  true,
  29
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;
