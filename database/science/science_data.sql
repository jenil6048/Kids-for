-- 1. Create science table and index
CREATE TABLE IF NOT EXISTS public.science (
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
  constraint science_pkey primary key (id),
  constraint science_topic_key_key unique (topic_key),
  constraint science_category_id_fkey foreign KEY (category_id) references categories (id) on delete CASCADE
) TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS idx_science_topic_key on public.science using btree (topic_key) TABLESPACE pg_default;

-- Disable Row Level Security (RLS) to fix private table access issues
ALTER TABLE public.science DISABLE ROW LEVEL SECURITY;

-- Grant permissions to anonymous client keys
GRANT ALL ON public.science TO anon;
GRANT ALL ON public.science TO authenticated;
GRANT ALL ON public.science TO service_role;

-- 2. Populate science table with data
-- Using matching as the primary game type

-- ITEM ATOM MODEL
INSERT INTO public.science 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'atom_model', 
  (SELECT id FROM categories WHERE category_key = 'science' LIMIT 1), 
  '{"en": "Atom Model", "gu": "અણુ મોડેલ", "hi": "परमाणु मॉडल"}'::jsonb, 
  '/assets/images/science/atom_model.png', 
  '{"en": "This is an Atom Model. Atoms are the tiny building blocks of everything.", "gu": "આ અણુ (એટમ) મોડેલ છે. અણુઓ આપણી આસપાસની તમામ વસ્તુઓના નાના બ્લોક્સ છે.", "hi": "यह परमाणु मॉडल है। परमाणु हमारे आस-पास की सभी चीजों के बहुत छोटे ब्लॉक होते हैं।"}'::jsonb, 
  '{"en": "Everything in the world is made of tiny atoms, but they are too small to see with our eyes. This model shows how they look with particles flying around.", "gu": "દુનિયાની દરેક વસ્તુ અણુઓથી બનેલી છે, પરંતુ તેઓ એટલા નાના હોય છે કે નરી આંખે જોઈ શકાતા નથી. આ મોડેલ દર્શાવે છે કે તેઓ કેવા દેખાય છે.", "hi": "दुनिया की हर चीज़ परमाणुओं से बनी है, लेकिन वे इतने छोटे होते हैं कि आँखों से नहीं देखे जा सकते। यह मॉडल दिखाता है कि वे कैसे दिखते हैं।"}'::jsonb, 
  '{"en": "Did you know? Millions of atoms could fit on the tip of a single pencil!", "gu": "શું તમે જાણો છો? લાખો અણુઓ એક પેન્સિલની અણી પર પણ સમાઈ શકે છે!", "hi": "क्या आप जानते हैं? लाखों परमाणु एक पेंसिल की नोक पर भी समा सकते हैं!"}'::jsonb, 
  'matching', 
  true, 
  1
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

-- ITEM BALANCE SCALE
INSERT INTO public.science 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'balance_scale', 
  (SELECT id FROM categories WHERE category_key = 'science' LIMIT 1), 
  '{"en": "Balance Scale", "gu": "ત્રાજવું", "hi": "तराजू"}'::jsonb, 
  '/assets/images/science/balance_scale.png', 
  '{"en": "This is a Balance Scale. It compares weights to see which object is heavier.", "gu": "આ ત્રાજવું છે. તે કઈ વસ્તુ ભારે છે તે જોવા માટે વજનની સરખામણી કરે છે.", "hi": "यह तराजू है। यह कौन सी वस्तु भारी है, यह देखने के लिए वजन की तुलना करता है।"}'::jsonb, 
  '{"en": "A balance scale has two pans. The side with the heavier object goes down, and the lighter side goes up. It helps us measure things.", "gu": "ત્રાજવાને બે પલ્લા હોય છે. ભારે વસ્તુવાળી બાજુ નીચે જાય છે, અને હલકી બાજુ ઉપર જાય છે. તે વજન માપવામાં મદદ કરે છે.", "hi": "तराजू में दो पलड़े होते हैं। भारी वस्तु वाली तरफ नीचे जाती है, और हल्की तरफ ऊपर जाती है। यह वजन मापने में मदद करता है।"}'::jsonb, 
  '{"en": "Did you know? Balance scales are one of the oldest invention tools, used since ancient times!", "gu": "શું તમે જાણો છો? ત્રાજવું એ સૌથી જૂના સાધનોમાંનું એક છે, જેનો ઉપયોગ પ્રાચીન સમયથી થાય છે!", "hi": "क्या आप जानते हैं? तराजू सबसे पुराने उपकरणों में से एक है, जिसका उपयोग प्राचीन काल से किया जा रहा है!"}'::jsonb, 
  'matching', 
  true, 
  2
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

-- ITEM BATTERY
INSERT INTO public.science 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'battery', 
  (SELECT id FROM categories WHERE category_key = 'science' LIMIT 1), 
  '{"en": "Battery", "gu": "બેટરી", "hi": "बैटरी"}'::jsonb, 
  '/assets/images/science/battery.png', 
  '{"en": "This is a Battery. Batteries store electricity to power our toys.", "gu": "આ બેટરી છે. બેટરી રમકડાં ચલાવવા માટે વીજળીનો સંગ્રહ કરે છે.", "hi": "यह बैटरी है। बैटरी खिलौने चलाने के लिए बिजली का भंडारण करती है।"}'::jsonb, 
  '{"en": "A battery holds chemical energy that turns into electricity. It helps flashlights, clocks, and remote controls work without wires.", "gu": "બેટરી રાસાયણિક ઉર્જા રાખે છે જે વીજળીમાં રૂપાંતરિત થાય છે. તે ટોર્ચ, ઘડિયાળ અને રીમોટ કંટ્રોલને વાયર વિના ચલાવે છે.", "hi": "बैटरी रासायनिक ऊर्जा रखती है जो बिजली में बदल जाती है। यह टॉर्च, घड़ी और रिमोट कंट्रोल को बिना तार के चलाने में मदद करती है।"}'::jsonb, 
  '{"en": "Did you know? The first battery was invented over 200 years ago using silver, zinc, and saltwater!", "gu": "શું તમે જાણો છો? પ્રથમ બેટરી ૨૦૦ વર્ષ પહેલાં ચાંદી, જસત અને મીઠાના પાણીથી બનાવવામાં આવી હતી!", "hi": "क्या आप जानते हैं? पहली बैटरी 200 साल से पहले चांदी, जस्ता और खारे पानी से बनाई गई थी!"}'::jsonb, 
  'matching', 
  true, 
  3
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

-- ITEM BEAKER
INSERT INTO public.science 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'beaker', 
  (SELECT id FROM categories WHERE category_key = 'science' LIMIT 1), 
  '{"en": "Beaker", "gu": "બીકર", "hi": "बीकर"}'::jsonb, 
  '/assets/images/science/beaker.png', 
  '{"en": "This is a Beaker. Beakers are glass cups used by scientists to hold liquids.", "gu": "આ બીકર છે. બીકર એ કાચના કપ છે જેનો ઉપયોગ વૈજ્ઞાનિકો પ્રવાહી રાખવા માટે કરે છે.", "hi": "यह बीकर है। बीकर कांच के कप होते हैं जिनका उपयोग वैज्ञानिक तरल पदार्थ रखने के लिए करते हैं।"}'::jsonb, 
  '{"en": "A beaker has lines on the side to measure how much liquid is inside. It is wide and has a small lip to make pouring water easy.", "gu": "બીકરની બાજુમાં અંકો વાળી રેખાઓ હોય છે જે પ્રવાહી માપવામાં મદદ કરે છે. તેમાં પાણી રેડવા માટે એક નાની ચાંચ હોય છે.", "hi": "बीकर के किनारे पर अंक वाली रेखाएँ होती हैं जो तरल को मापने में मदद करती हैं। इसमें पानी डालने के लिए एक छोटी चोंच होती है।"}'::jsonb, 
  '{"en": "Did you know? Beakers are made of special glass that does not crack even when heated over a fire!", "gu": "શું તમે જાણો છો? બીકર ખાસ કાચમાંથી બને છે જે આગ પર ગરમ કરવા છતાં પણ તૂટતા નથી!", "hi": "क्या आप जानते हैं? बीकर विशेष कांच से बने होते हैं जो आग पर गर्म करने पर भी नहीं टूटते!"}'::jsonb, 
  'matching', 
  true, 
  4
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

-- ITEM BIOLOGICAL CELL
INSERT INTO public.science 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'biological_cell', 
  (SELECT id FROM categories WHERE category_key = 'science' LIMIT 1), 
  '{"en": "Biological Cell", "gu": "જૈવિક કોષ", "hi": "जैविक कोशिका"}'::jsonb, 
  '/assets/images/science/biological_cell.png', 
  '{"en": "This is a Biological Cell. Cells are the tiny building blocks of all living things.", "gu": "આ જૈવિક કોષ છે. કોષો એ તમામ સજીવોના નાના રચનાત્મક એકમો છે.", "hi": "यह जैविक कोशिका है। कोशिकाएं सभी जीवित चीजों की छोटी रचनात्मक इकाइयाँ होती हैं।"}'::jsonb, 
  '{"en": "Plants, animals, and humans are made of billions of tiny cells. Each cell has a special job to keep the body alive and healthy.", "gu": "છોડ, પ્રાણીઓ અને મનુષ્યો અબજો કોષોના બનેલા છે. શરીરને જીવંત અને સ્વસ્થ રાખવા માટે દરેક કોષનું ખાસ કામ હોય છે.", "hi": "पौधे, जानवर और मनुष्य अरबों कोशिकाओं से बने हैं। शरीर को जीवित और स्वस्थ रखने के लिए हर कोशिका का विशेष काम होता है।"}'::jsonb, 
  '{"en": "Did you know? You have about 37 trillion cells inside your body right now!", "gu": "શું તમે જાણો છો? અત્યારે તમારા શરીરમાં લગભગ ૩૭ ટ્રિલિયન (અબજો) કોષો છે!", "hi": "क्या आप जानते हैं? अभी आपके शरीर में लगभग 37 ट्रिलियन (अरबों) कोशिकाएं हैं!"}'::jsonb, 
  'matching', 
  true, 
  5
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

-- ITEM BRAIN MODEL
INSERT INTO public.science 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'brain_model', 
  (SELECT id FROM categories WHERE category_key = 'science' LIMIT 1), 
  '{"en": "Brain Model", "gu": "મગજ મોડેલ", "hi": "मस्तिष्क मॉडल"}'::jsonb, 
  '/assets/images/science/brain_model.png', 
  '{"en": "This is a Brain Model. The brain controls everything we think, feel, and do.", "gu": "આ મગજ મોડેલ છે. મગજ આપણે જે વિચારીએ, અનુભવીએ અને કરીએ છીએ તે બધું જ નિયંત્રિત કરે છે.", "hi": "यह मस्तिष्क मॉडल है। मस्तिष्क हमारे सोचने, महसूस करने और करने की हर चीज़ को नियंत्रित करता है।"}'::jsonb, 
  '{"en": "The brain sits inside our head protected by the skull. It acts like a supercomputer that sends messages to our body to move and talk.", "gu": "મગજ આપણા માથામાં ખોપરીની અંદર સુરક્ષિત હોય છે. તે સુપરકોમ્પ્યુટર જેવું કામ કરે છે જે શરીરને હલનચલન માટે સંદેશા મોકલે છે.", "hi": "मस्तिष्क हमारे सिर में खोपड़ी के अंदर सुरक्षित होता है। यह सुपरकंप्यूटर की तरह काम करता है जो शरीर को चलने-फिरने के संदेश भेजता है।"}'::jsonb, 
  '{"en": "Did you know? Your brain is active even when you are fast asleep, helping you dream!", "gu": "શું તમે જાણો છો? જ્યારે તમે ઊંડાણપૂર્વક સૂતા હોવ ત્યારે પણ તમારું મગજ સક્રિય હોય છે, જે તમને સપના જોવામાં મદદ કરે છે!", "hi": "क्या आप जानते हैं? जब आप सो रहे होते हैं तब भी आपका मस्तिष्क सक्रिय रहता है, जो आपको सपने देखने में मदद करता है!"}'::jsonb, 
  'matching', 
  true, 
  6
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

-- ITEM BUNSEN BURNER
INSERT INTO public.science 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'bunsen_burner', 
  (SELECT id FROM categories WHERE category_key = 'science' LIMIT 1), 
  '{"en": "Bunsen Burner", "gu": "બન્સન બર્નર", "hi": "बुन्सेन बर्नर"}'::jsonb, 
  '/assets/images/science/bunsen_burner.png', 
  '{"en": "This is a Bunsen Burner. It makes a hot flame to heat things in science labs.", "gu": "આ બન્સન બર્નર છે. તે વિજ્ઞાન પ્રયોગશાળામાં વસ્તુઓને ગરમ કરવા માટે જ્યોત બનાવે છે.", "hi": "यह बुन्सेन बर्नर है। यह विज्ञान प्रयोगशाला में चीजों को गर्म करने के लिए आग की लौ बनाता है।"}'::jsonb, 
  '{"en": "A Bunsen burner mixes gas with air to make a clean, blue flame. Scientists use it to melt substances or perform hot experiments.", "gu": "બન્સન બર્નર ગેસ અને હવાનું મિશ્રણ કરીને ગરમ ભૂરી જ્યોત બનાવે છે. વૈજ્ઞાનિકો પ્રયોગો કરવા માટે તેનો ઉપયોગ કરે છે.", "hi": "बुन्सेन बर्नर गैस और हवा को मिलाकर एक गर्म नीली लौ बनाता है। वैज्ञानिक प्रयोग करने के लिए इसका उपयोग करते हैं।"}'::jsonb, 
  '{"en": "Did you know? The Bunsen burner was invented by a chemist named Robert Bunsen in 1855!", "gu": "શું તમે જાણો છો? બન્સન બર્નરની શોધ ૧૮૫૫ માં રોબર્ટ બન્સન નામના રસાયણશાસ્ત્રી દ્વારા કરવામાં આવી હતી!", "hi": "क्या आप जानते हैं? बुन्सेन बर्नर का आविष्कार 1855 में रॉबर्ट बुन्सेन नामक रसायनशास्त्री द्वारा किया गया था!"}'::jsonb, 
  'matching', 
  true, 
  7
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

-- ITEM CRYSTAL
INSERT INTO public.science 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'crystal', 
  (SELECT id FROM categories WHERE category_key = 'science' LIMIT 1), 
  '{"en": "Crystal", "gu": "સ્ફટિક", "hi": "क्रिस्टल"}'::jsonb, 
  '/assets/images/science/crystal.png', 
  '{"en": "This is a Crystal. Crystals are beautiful rocks that grow in neat, geometric shapes.", "gu": "આ સ્ફટિક (ક્રિસ્ટલ) છે. સ્ફટિકો એ સુંદર પથ્થરો છે જે ભૌમિતિક આકારોમાં કુદરતી રીતે બને છે.", "hi": "यह क्रिस्टल है। क्रिस्टल सुंदर पत्थर होते हैं जो ज्यामितीय आकारों में प्राकृतिक रूप से बनते हैं।"}'::jsonb, 
  '{"en": "Crystals form deep underground when minerals cool slowly. They have shiny surfaces and can be colorful, like purple quartz or green emerald.", "gu": "જ્યારે ખનિજો ધીમે ધીમે ઠંડા થાય ત્યારે જમીનની અંદર સ્ફટિકો બને છે. તેઓ ચમકદાર સપાટી ધરાવે છે અને રંગીન હોઈ શકે છે.", "hi": "जब खनिज धीरे-धीरे ठंडे होते हैं तो जमीन के अंदर क्रिस्टल बनते हैं। उनकी सतह चमकदार होती है और वे रंगीन हो सकते हैं।"}'::jsonb, 
  '{"en": "Did you know? Snowflakes and sugar are actually types of crystals!", "gu": "શું તમે જાણો છો? બરફના ટુકડા (સ્નોફ્લેક્સ) અને ખાંડ પણ વાસ્તવમાં સ્ફટિકના પ્રકારો છે!", "hi": "क्या आप जानते हैं? बर्फ के टुकड़े (स्नोफ्लेक्स) और चीनी भी वास्तव में क्रिस्टल के प्रकार हैं!"}'::jsonb, 
  'matching', 
  true, 
  8
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

-- ITEM DINOSAUR FOSSIL
INSERT INTO public.science 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'dinosaur_fossil', 
  (SELECT id FROM categories WHERE category_key = 'science' LIMIT 1), 
  '{"en": "Dinosaur Fossil", "gu": "ડાયનાસોર અશ્મિ", "hi": "डायनासोर जीवाश्म"}'::jsonb, 
  '/assets/images/science/dinosaur_fossil.png', 
  '{"en": "This is a Dinosaur Fossil. Fossils are the ancient bones of dinosaurs turned into stone.", "gu": "આ ડાયનાસોર અશ્મિ છે. અશ્મિ એ પથ્થર બની ગયેલા ડાયનાસોરના હજારો વર્ષ જૂના હાડકાં છે.", "hi": "यह डायनासोर जीवाश्म है। जीवाश्म पत्थर में बदल चुकी डायनासोर की हजारों साल पुरानी हड्डियाँ होती हैं।"}'::jsonb, 
  '{"en": "Fossils are found buried deep in the ground. They help scientists learn what dinosaurs looked like and how they lived millions of years ago.", "gu": "અશ્મિ જમીનની અંદર દટાયેલા મળી આવે છે. તેઓ વૈજ્ઞાનિકોને લાખો વર્ષ પહેલાં ડાયનાસોર કેવા દેખાતા હતા તે જાણવામાં મદદ કરે છે.", "hi": "जीवाश्म जमीन के अंदर दबे हुए मिलते हैं। वे वैज्ञानिकों को यह जानने में मदद करते हैं कि लाखों साल पहले डायनासोर कैसे दिखते थे।"}'::jsonb, 
  '{"en": "Did you know? The word ''fossil'' comes from a Latin word meaning ''obtained by digging''!", "gu": "શું તમે જાણો છો? ''ફોસિલ'' શબ્દ લેટિન શબ્દ પરથી આવ્યો છે જેનો અર્થ ''ખોદકામ દ્વારા મેળવેલ'' થાય છે!", "hi": "क्या आप जानते हैं? ''फॉसिल'' शब्द लैटिन शब्द से आया है जिसका अर्थ ''खुदाई द्वारा प्राप्त'' होता है!"}'::jsonb, 
  'matching', 
  true, 
  9
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

-- ITEM DNA
INSERT INTO public.science 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'dna', 
  (SELECT id FROM categories WHERE category_key = 'science' LIMIT 1), 
  '{"en": "DNA", "gu": "ડીએનએ", "hi": "डीएनए"}'::jsonb, 
  '/assets/images/science/dna.png', 
  '{"en": "This is DNA. DNA is like an instruction book for our body.", "gu": "આ ડીએનએ છે. ડીએનએ આપણા શરીર માટેની માર્ગદર્શિકા (સૂચના પુસ્તક) જેવું છે.", "hi": "यह डीएनए है। डीएनए हमारे शरीर के लिए एक निर्देश पुस्तिका की तरह है।"}'::jsonb, 
  '{"en": "DNA is shaped like a twisted ladder. It decides our eye color, hair color, and how tall we will grow. It makes everyone unique.", "gu": "ડીએનએનો આકાર વળાંકવાળી સીડી જેવો હોય છે. તે આપણી આંખોનો રંગ, વાળનો રંગ અને આપણી ઊંચાઈ નક્કી કરે છે.", "hi": "डीएनए का आकार घुमावदार सीढ़ी जैसा होता है। यह हमारी आंखों का रंग, बालों का रंग और हमारी लंबाई तय करता है।"}'::jsonb, 
  '{"en": "Did you know? If you unraveled all the DNA in your body, it would reach the sun and back many times!", "gu": "શું તમે જાણો છો? જો તમે તમારા શરીરના તમામ ડીએનએ ખોલો, તો તે સૂર્ય સુધી પહોંચીને ઘણી વખત પાછું આવી શકે છે!", "hi": "क्या आप जानते हैं? यदि आप अपने शरीर के सभी डीएनए को खोलें, तो यह सूर्य तक पहुँचकर कई बार वापस आ सकता है!"}'::jsonb, 
  'matching', 
  true, 
  10
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

-- ITEM DROPPER
INSERT INTO public.science 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'dropper', 
  (SELECT id FROM categories WHERE category_key = 'science' LIMIT 1), 
  '{"en": "Dropper", "gu": "ડ્રોપર", "hi": "ड्रॉपर"}'::jsonb, 
  '/assets/images/science/dropper.png', 
  '{"en": "This is a Dropper. Droppers move liquid one tiny drop at a time.", "gu": "આ ડ્રોપર છે. ડ્રોપર પ્રવાહીને એક સમયે એક નાના ટીપાં તરીકે ખસેડે છે.", "hi": "यह ड्रॉपर है। ड्रॉपर तरल को एक बार में एक छोटी बूंद के रूप में ले जाता है।"}'::jsonb, 
  '{"en": "A dropper has a rubber bulb on top. We squeeze the bulb to suck liquid in, and squeeze gently to let drops fall out.", "gu": "ડ્રોપરમાં ઉપર રબરનો બલ્બ હોય છે. પ્રવાહી અંદર ખેંચવા આપણે બલ્બ દબાવીએ છીએ, અને ટીપાં બહાર પાડવા હળવેથી દબાવીએ છીએ.", "hi": "ड्रॉपर में ऊपर रबर का बल्ब होता है। तरल को अंदर खींचने के लिए हम बल्ब दबाते हैं, और बूंदें गिराने के लिए इसे धीरे से दबाते हैं।"}'::jsonb, 
  '{"en": "Did you know? Droppers are very helpful for giving medicine to small babies safely!", "gu": "શું તમે જાણો છો? નાના બાળકોને સુરક્ષિત રીતે દવા આપવા માટે ડ્રોપર્સ ખૂબ જ ઉપયોગી છે!", "hi": "क्या आप जानते हैं? छोटे बच्चों को सुरक्षित रूप से दवा देने के लिए ड्रॉपर बहुत उपयोगी होते हैं!"}'::jsonb, 
  'matching', 
  true, 
  11
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

-- ITEM ELECTRIC CIRCUIT
INSERT INTO public.science 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'electric_circuit', 
  (SELECT id FROM categories WHERE category_key = 'science' LIMIT 1), 
  '{"en": "Electric Circuit", "gu": "વિદ્યુત પરિપથ", "hi": "विद्युत परिपथ"}'::jsonb, 
  '/assets/images/science/electric_circuit.png', 
  '{"en": "This is an Electric Circuit. It is a loop that lets electricity flow to light up a bulb.", "gu": "આ વિદ્યુત પરિપથ છે. તે એક લૂપ (બંધ રસ્તો) છે જે બલ્બને પ્રકાશિત કરવા માટે વીજળી વહેવા દે છે.", "hi": "यह विद्युत परिपथ है। यह एक बंद रास्ता है जो बल्ब को जलाने के लिए बिजली बहने देता है।"}'::jsonb, 
  '{"en": "An electric circuit connects a battery, wires, and a bulb. When the switch is closed, electricity flows in a circle and the bulb shines.", "gu": "વિદ્યુત પરિપથ બેટરી, વાયર અને બલ્બને જોડે છે. જ્યારે સ્વીચ ચાલુ કરવામાં આવે છે, ત્યારે વીજળી વર્તુળમાં વહે છે અને બલ્બ ચાલુ થાય છે.", "hi": "विद्युत परिपथ बैटरी, तारों और बल्ब को जोड़ता है। जब स्विच चालू किया जाता है, तो बिजली गोल घूमती है और बल्ब जल जाता है।"}'::jsonb, 
  '{"en": "Did you know? Electricity travels through wires at almost the speed of light!", "gu": "શું તમે જાણો છો? વીજળી વાયરોમાંથી લગભગ પ્રકાશની ઝડપે પસાર થાય છે!", "hi": "क्या आप जानते हैं? बिजली तारों से लगभग प्रकाश की गति से यात्रा करती है!"}'::jsonb, 
  'matching', 
  true, 
  12
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

-- ITEM FLASK
INSERT INTO public.science 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'erlenmeyer_flask', 
  (SELECT id FROM categories WHERE category_key = 'science' LIMIT 1), 
  '{"en": "Flask", "gu": "ફ્લાસ્ક", "hi": "फ्लास्क"}'::jsonb, 
  '/assets/images/science/erlenmeyer_flask.png', 
  '{"en": "This is a Flask. It is a cone-shaped glass bottle used in labs.", "gu": "આ ફ્લાસ્ક છે. તે પ્રયોગશાળાઓમાં વપરાતી શંકુ આકારની કાચની બોટલ છે.", "hi": "यह फ्लास्क है। यह प्रयोगशालाओं में उपयोग की जाने वाली शंक्वाकार कांच की बोतल है।"}'::jsonb, 
  '{"en": "A flask has a wide bottom and a narrow neck. This shape allows scientists to swirl liquids around without spilling them.", "gu": "ફ્લાસ્કને પહોળું તળિયું અને સાંકડી ગરદન હોય છે. આ આકાર વૈજ્ઞાનિકોને પ્રવાહી ઢોળાયા વિના હલાવવામાં મદદ કરે છે.", "hi": "फ्लास्क का निचला हिस्सा चौड़ा और गर्दन संकरी होती है। यह आकार वैज्ञानिकों को तरल को गिराए बिना हिलाने में मदद करता है।"}'::jsonb, 
  '{"en": "Did you know? The flask is named after Emil Erlenmeyer, the German chemist who invented it in 1860!", "gu": "શું તમે જાણો છો? ફ્લાસ્કનું નામ જર્મન રસાયણશાસ્ત્રી એમિલ ઇર્લેનમેયર પરથી રાખવામાં આવ્યું છે જેમણે ૧૮૬૦ માં તેની શોધ કરી હતી!", "hi": "क्या आप जानते हैं? फ्लास्क का नाम जर्मन रसायनशास्त्री एमिल एर्लेनमेयर के नाम पर रखा गया है जिन्होंने 1860 में इसका आविष्कार किया था!"}'::jsonb, 
  'matching', 
  true, 
  13
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

-- ITEM GLOBE
INSERT INTO public.science 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'globe', 
  (SELECT id FROM categories WHERE category_key = 'science' LIMIT 1), 
  '{"en": "Globe", "gu": "પૃથ્વીનો ગોળો", "hi": "ग्लोब"}'::jsonb, 
  '/assets/images/science/globe.png', 
  '{"en": "This is a Globe. A globe is a round model of our planet Earth.", "gu": "આ પૃથ્વીનો ગોળો (ગ્લોબ) છે. પૃથ્વીનો ગોળો એ આપણી પૃથ્વીનું એક ગોળ મોડેલ છે.", "hi": "यह ग्लोब है। ग्लोब हमारे ग्रह पृथ्वी का एक गोल मॉडल है।"}'::jsonb, 
  '{"en": "A globe spins just like the real Earth. It shows where oceans, lands, and countries are located. It helps us see the world.", "gu": "પૃથ્વીનો ગોળો વાસ્તવિક પૃથ્વીની જેમ જ ફરે છે. તે દર્શાવે છે કે મહાસાગરો, જમીન અને દેશો ક્યાં આવેલા છે.", "hi": "ग्लोब वास्तविक पृथ्वी की तरह ही घूमता है। यह दिखाता है कि महासागर, भूमि और देश कहाँ स्थित हैं।"}'::jsonb, 
  '{"en": "Did you know? The oldest surviving globe was made over 500 years ago, even before America was on maps!", "gu": "શું તમે જાણો છો? અસ્તિત્વ ધરાવતો સૌથી જૂનો પૃથ્વીનો ગોળો ૫૦૦ વર્ષ પહેલાં બનાવવામાં આવ્યો હતો!", "hi": "क्या आप जानते हैं? अस्तित्व में सबसे पुराना ग्लोब 500 साल पहले बनाया गया था!"}'::jsonb, 
  'matching', 
  true, 
  14
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

-- ITEM GRADUATED CYLINDER
INSERT INTO public.science 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'graduated_cylinder', 
  (SELECT id FROM categories WHERE category_key = 'science' LIMIT 1), 
  '{"en": "Graduated Cylinder", "gu": "માપન નળાકાર", "hi": "अंशांकित बेलन"}'::jsonb, 
  '/assets/images/science/graduated_cylinder.png', 
  '{"en": "This is a Graduated Cylinder. It measures the volume of liquids precisely.", "gu": "આ માપન નળાકાર છે. તે પ્રવાહીના જથ્થાને ચોક્કસ રીતે માપે છે.", "hi": "यह अंशांकित बेलन है। यह तरल की मात्रा को सटीक रूप से मापता है।"}'::jsonb, 
  '{"en": "It is a tall, narrow cylinder with mark lines. Scientists read the lines to find exactly how much water is inside.", "gu": "તે અંકિત રેખાઓ ધરાવતો લાંબો, સાંકડો નળાકાર છે. વૈજ્ઞાનિકો પ્રવાહીનું ચોક્કસ માપ જાણવા માટે આ રેખાઓ વાંચે છે.", "hi": "यह चिह्नित रेखाओं वाला एक लंबा, संकरा बेलन है। वैज्ञानिक तरल की सटीक मात्रा जानने के लिए इन रेखाओं को पढ़ते हैं।"}'::jsonb, 
  '{"en": "Did you know? To get a correct reading, you must look at the bottom of the curved water surface, called the meniscus!", "gu": "શું તમે જાણો છો? સાચું માપ મેળવવા માટે, તમારે પાણીની વક્ર સપાટીના તળિયે જોવું પડે છે, જેને મેનિસ્કસ કહેવાય છે!", "hi": "क्या आप जानते हैं? सही माप के लिए, आपको पानी की घुमावदार सतह के निचले हिस्से को देखना होता है, जिसे मेनिस्कस कहते हैं!"}'::jsonb, 
  'matching', 
  true, 
  15
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

-- ITEM HUMAN HEART
INSERT INTO public.science 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'human_heart', 
  (SELECT id FROM categories WHERE category_key = 'science' LIMIT 1), 
  '{"en": "Human Heart", "gu": "હૃદય", "hi": "मानव हृदय"}'::jsonb, 
  '/assets/images/science/human_heart.png', 
  '{"en": "This is a Human Heart. The heart pumps blood all around our body.", "gu": "આ હૃદય છે. હૃદય આપણા સમગ્ર શરીરમાં લોહીનું પરિભ્રમણ કરાવે છે.", "hi": "यह मानव हृदय है। हृदय हमारे पूरे शरीर में रक्त का संचार करता है।"}'::jsonb, 
  '{"en": "The heart is a strong muscle inside our chest. It beats day and night to deliver oxygen and energy to all parts of our body.", "gu": "હૃદય આપણી છાતીની અંદર આવેલો એક મજબૂત સ્નાયુ છે. તે શરીરના તમામ ભાગોમાં ઓક્સિજન પહોંચાડવા દિવસ-રાત ધબકે છે.", "hi": "हृदय हमारी छाती के अंदर एक मजबूत मांसपेशी है। यह शरीर के सभी हिस्सों में ऑक्सीजन पहुंचाने के लिए दिन-रात धड़कता है।"}'::jsonb, 
  '{"en": "Did you know? Your heart is about the same size as your closed fist!", "gu": "શું તમે જાણો છો? તમારું હૃદય તમારી બંધ મુઠ્ઠી જેટલા જ કદનું હોય છે!", "hi": "क्या आप जानते हैं? आपका हृदय आपकी बंद मुट्ठी के आकार का होता है!"}'::jsonb, 
  'matching', 
  true, 
  16
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

-- ITEM HUMAN SKELETON
INSERT INTO public.science 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'human_skeleton', 
  (SELECT id FROM categories WHERE category_key = 'science' LIMIT 1), 
  '{"en": "Human Skeleton", "gu": "હાડપિંજર", "hi": "मानव कंकाल"}'::jsonb, 
  '/assets/images/science/human_skeleton.png', 
  '{"en": "This is a Human Skeleton. The skeleton is the framework of bones inside us.", "gu": "આ હાડપિંજર છે. હાડપિંજર એ આપણા શરીરની અંદર રહેલો હાડકાંનો ઢાંચો છે.", "hi": "यह मानव कंकाल है। कंकाल हमारे शरीर के अंदर हड्डियों का ढांचा होता है।"}'::jsonb, 
  '{"en": "Bones are hard and strong. The skeleton protects our soft organs like the brain and heart, and helps us stand and walk.", "gu": "હાડકાં કઠણ અને મજબૂત હોય છે. હાડપિંજર મગજ અને હૃદય જેવા નાજુક અંગોનું રક્ષણ કરે છે, અને આપણને ઊભા રહેવામાં મદદ કરે છે.", "hi": "हड्डियाँ कठोर और मजबूत होती हैं। कंकाल मस्तिष्क और हृदय जैसे नाजुक अंगों की रक्षा करता है, और हमें खड़े होने में मदद करता है।"}'::jsonb, 
  '{"en": "Did you know? Adults have 206 bones, but babies are born with about 300 bones!", "gu": "શું તમે જાણો છો? પુખ્ત વયના લોકોમાં ૨૦૬ હાડકાં હોય છે, પરંતુ બાળકો આશરે ૩૦૦ હાડકાં સાથે જન્મે છે!", "hi": "क्या आप जानते हैं? वयस्कों में 206 हड्डियाँ होती हैं, लेकिन बच्चे लगभग 300 हड्डियों के साथ पैदा होते हैं!"}'::jsonb, 
  'matching', 
  true, 
  17
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

-- ITEM LEAF CELL
INSERT INTO public.science 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'leaf_cell', 
  (SELECT id FROM categories WHERE category_key = 'science' LIMIT 1), 
  '{"en": "Leaf Cell", "gu": "પાંદડાનો કોષ", "hi": "पत्ती की कोशिका"}'::jsonb, 
  '/assets/images/science/leaf_cell.png', 
  '{"en": "This is a Leaf Cell. Leaf cells are tiny units that make food for plants.", "gu": "આ પાંદડાનો કોષ છે. પાંદડાના કોષો એ નાના એકમો છે જે છોડ માટે ખોરાક બનાવે છે.", "hi": "यह पत्ती की कोशिका है। पत्ती की कोशिकाएं छोटी इकाइयाँ होती हैं जो पौधों के लिए भोजन बनाती हैं।"}'::jsonb, 
  '{"en": "Leaf cells contain green parts called chloroplasts. They use sunlight, water, and air to make food in a process called photosynthesis.", "gu": "પાંદડાના કોષોમાં હરિતકણ (ક્લોરોપ્લાસ્ટ) હોય છે. તેઓ પ્રકાશસંશ્લેષણ દ્વારા ખોરાક બનાવવા સૂર્યપ્રકાશનો ઉપયોગ કરે છે.", "hi": "पत्ती की कोशिकाओं में क्लोरोप्लास्ट होते हैं। वे प्रकाश संश्लेषण द्वारा भोजन बनाने के लिए सूर्य के प्रकाश का उपयोग करते हैं।"}'::jsonb, 
  '{"en": "Did you know? Leaf cells are green because of a special pigment called chlorophyll, which traps sunlight!", "gu": "શું તમે જાણો છો? હરિતદ્રવ્ય (ક્લોરોફિલ) નામના દ્રવ્યને કારણે પાંદડાના કોષો લીલા રંગના દેખાય છે!", "hi": "क्या आप जानते हैं? क्लोरोफिल नामक पदार्थ के कारण पत्ती की कोशिकाएं हरी दिखाई देती हैं!"}'::jsonb, 
  'matching', 
  true, 
  18
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

-- ITEM LIGHT BULB
INSERT INTO public.science 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'light_bulb', 
  (SELECT id FROM categories WHERE category_key = 'science' LIMIT 1), 
  '{"en": "Light Bulb", "gu": "વીજળીનો ગોળો", "hi": "बिजली का बल्ब"}'::jsonb, 
  '/assets/images/science/light_bulb.png', 
  '{"en": "This is a Light Bulb. Light bulbs turn electricity into bright light.", "gu": "આ વીજળીનો ગોળો (બલ્બ) છે. બલ્બ વીજળીને તેજસ્વી પ્રકાશમાં રૂપાંતરિત કરે છે.", "hi": "यह बिजली का बल्ब है। बल्ब बिजली को चमकीले प्रकाश में बदलता है।"}'::jsonb, 
  '{"en": "Inside the bulb, a tiny wire gets very hot and glows when electricity flows through it. It helps us see inside our home at night.", "gu": "બલ્બની અંદર, વીજળી પસાર થતાં એક નાનો વાયર ગરમ થઈને પ્રકાશ આપે છે. તે આપણને રાત્રે ઘરમાં જોવામાં મદદ કરે છે.", "hi": "बल्ब के अंदर, बिजली प्रवाहित होने पर एक छोटा तार गर्म होकर रोशनी देता है। यह हमें रात में घर में देखने में मदद करता है।"}'::jsonb, 
  '{"en": "Did you know? Thomas Edison invented the first practical light bulb that could burn for hours in 1879!", "gu": "શું તમે જાણો છો? થોમસ એડિસને ૧૮૭૯ માં પ્રથમ વ્યવહારુ લાઇટ બલ્બની શોધ કરી હતી!", "hi": "क्या आप जानते हैं? थॉमस एडिसन ने 1879 में पहले व्यावहारिक प्रकाश बल्ब का आविष्कार किया था!"}'::jsonb, 
  'matching', 
  true, 
  19
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

-- ITEM MAGNET
INSERT INTO public.science 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'magnet', 
  (SELECT id FROM categories WHERE category_key = 'science' LIMIT 1), 
  '{"en": "Magnet", "gu": "ચુંબક", "hi": "चुंबक"}'::jsonb, 
  '/assets/images/science/magnet.png', 
  '{"en": "This is a Magnet. Magnets pull metal objects toward them.", "gu": "આ ચુંબક છે. ચુંબક લોખંડની વસ્તુઓને પોતાની તરફ ખેંચે છે.", "hi": "यह चुंबक है। चुंबक लोहे की वस्तुओं को अपनी ओर खींचता है।"}'::jsonb, 
  '{"en": "Magnets have an invisible force called magnetism. They can stick to refrigerators and hold papers. They have a North and a South pole.", "gu": "ચુંબકમાં અદ્રશ્ય આકર્ષણ બળ (ચુંબકત્વ) હોય છે. તેઓ ફ્રિજ પર ચોંટી શકે છે. તેમને ઉત્તર અને દક્ષિણ ધ્રુવ હોય છે.", "hi": "चुंबक में अदृश्य चुंबकीय बल होता है। वे फ्रिज पर चिपक सकते हैं। उनके उत्तर और दक्षिण ध्रुव होते हैं।"}'::jsonb, 
  '{"en": "Did you know? The Earth itself is a giant magnet with its own magnetic poles!", "gu": "શું તમે જાણો છો? પૃથ્વી પોતે જ એક વિશાળ ચુંબક છે જેના પોતાના ચુંબકીય ધ્રુવો છે!", "hi": "क्या आप जानते हैं? पृथ्वी स्वयं एक विशाल चुंबक है जिसके अपने चुंबकीय ध्रुव हैं!"}'::jsonb, 
  'matching', 
  true, 
  20
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

-- ITEM MAGNIFYING GLASS
INSERT INTO public.science 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'magnifying_glass', 
  (SELECT id FROM categories WHERE category_key = 'science' LIMIT 1), 
  '{"en": "Magnifying Glass", "gu": "બિલોરી કાચ", "hi": "आवर्धक लेंस (magnifying glass)"}'::jsonb, 
  '/assets/images/science/magnifying_glass.png', 
  '{"en": "This is a Magnifying Glass. It makes tiny things look much bigger.", "gu": "આ બિલોરી કાચ છે. તે નાની વસ્તુઓને ઘણી મોટી બતાવે છે.", "hi": "यह आवर्धक लेंस है। यह छोटी चीजों को बहुत बड़ा दिखाता है।"}'::jsonb, 
  '{"en": "A magnifying glass has a curved lens. When you look through it, details of insects, leaves, or tiny words become easy to see.", "gu": "બિલોરી કાચમાં વળાંકવાળો કાચ (લેન્સ) હોય છે. જ્યારે તમે તેમાંથી જુઓ છો, ત્યારે જંતુઓ કે નાના અક્ષરો સ્પષ્ટ દેખાય છે.", "hi": "आवर्धक लेंस में घुमावदार कांच होता है। जब आप इसके माध्यम से देखते हैं, तो कीड़े या छोटे अक्षर स्पष्ट दिखाई देते हैं।"}'::jsonb, 
  '{"en": "Did you know? Magnifying glasses can concentrate sunlight into a tiny hot spot to start a fire!", "gu": "શું તમે જાણો છો? બિલોરી કાચ સૂર્યપ્રકાશને એક નાની ગરમ જગ્યા પર કેન્દ્રિત કરીને આગ પ્રગટાવી શકે છે!", "hi": "क्या आप जानते हैं? आवर्धक लेंस सूर्य के प्रकाश को एक छोटे गर्म स्थान पर केंद्रित करके आग जला सकता है!"}'::jsonb, 
  'matching', 
  true, 
  21
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

-- ITEM MICROSCOPE
INSERT INTO public.science 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'microscope', 
  (SELECT id FROM categories WHERE category_key = 'science' LIMIT 1), 
  '{"en": "Microscope", "gu": "સૂક્ષ્મદર્શક યંત્ર", "hi": "सूक्ष्मदर्शी (microscope)"}'::jsonb, 
  '/assets/images/science/microscope.png', 
  '{"en": "This is a Microscope. It lets us see super tiny things that are invisible to our eyes.", "gu": "આ સૂક્ષ્મદર્શક યંત્ર છે. તે આપણને અદ્રશ્ય એવી અતિ સૂક્ષ્મ વસ્તુઓ જોવામાં મદદ કરે છે.", "hi": "यह सूक्ष्मदर्शी है। यह हमें अदृश्य जैसी अत्यंत सूक्ष्म चीजों को देखने में मदद करता है।"}'::jsonb, 
  '{"en": "A microscope uses strong lenses to zoom in on things like cells, bacteria, or water drops. Scientists use it to study germs.", "gu": "સૂક્ષ્મદર્શક યંત્ર કોષો કે પાણીના ટીપાં જેવી વસ્તુઓ ઝૂમ કરવા માટે પાવરફુલ લેન્સ વાપરે છે. વૈજ્ઞાનિકો તેનો અભ્યાસ માટે ઉપયોગ કરે છે.", "hi": "सूक्ष्मदर्शी कोशिकाओं या पानी की बूंदों जैसी चीजों को ज़ूम करने के लिए शक्तिशाली लेंस का उपयोग करता है। वैज्ञानिक इसका उपयोग अध्ययन के लिए करते हैं।"}'::jsonb, 
  '{"en": "Did you know? The first microscopes were invented in the Netherlands over 400 years ago!", "gu": "શું તમે જાણો છો? ૪૦૦ વર્ષ પહેલાં નેધરલેન્ડ્સમાં પ્રથમ સૂક્ષ્મદર્શક યંત્રની શોધ થઈ હતી!", "hi": "क्या आप जानते हैं? 400 साल पहले नीदरलैंड में पहले सूक्ष्मदर्शी का आविष्कार हुआ था!"}'::jsonb, 
  'matching', 
  true, 
  22
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

-- ITEM MOLECULE MODEL
INSERT INTO public.science 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'molecule_model', 
  (SELECT id FROM categories WHERE category_key = 'science' LIMIT 1), 
  '{"en": "Molecule Model", "gu": "અણુ મોડેલ", "hi": "अणु मॉडल"}'::jsonb, 
  '/assets/images/science/molecule_model.png', 
  '{"en": "This is a Molecule Model. A molecule is formed when two or more atoms join together.", "gu": "આ અણુ (મોલેક્યુલ) મોડેલ છે. જ્યારે બે કે તેથી વધુ પરમાણુઓ એકસાથે જોડાય ત્યારે અણુ બને છે.", "hi": "यह अणु मॉडल है। जब दो या दो से अधिक परमाणु एक साथ जुड़ते हैं तो अणु बनता है।"}'::jsonb, 
  '{"en": "Atoms connect like puzzle pieces to make molecules. For example, two hydrogen atoms and one oxygen atom join to make water.", "gu": "પરમાણુઓ કોયડાના ટુકડાની જેમ જોડાઈને અણુ બનાવે છે. ઉદાહરણ તરીકે, બે હાઇડ્રોજન અને એક ઓક્સિજન મળીને પાણી બને છે.", "hi": "परमाणु पहेली के टुकड़ों की तरह जुड़कर अणु बनाते हैं। उदाहरण के लिए, दो हाइड्रोजन और एक ऑक्सीजन मिलकर पानी बनाते हैं।"}'::jsonb, 
  '{"en": "Did you know? Water is a molecule made of oxygen and hydrogen, and it is written as H2O!", "gu": "શું તમે જાણો છો? પાણી એ ઓક્સિજન અને હાઇડ્રોજનથી બનેલો અણુ છે, જેને H2O લખવામાં આવે છે!", "hi": "क्या आप जानते हैं? पानी ऑक्सीजन और हाइड्रोजन से बना एक अणु है, जिसे H2O लिखा जाता है!"}'::jsonb, 
  'matching', 
  true, 
  23
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

-- ITEM PETRI DISH
INSERT INTO public.science 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'petri_dish', 
  (SELECT id FROM categories WHERE category_key = 'science' LIMIT 1), 
  '{"en": "Petri Dish", "gu": "પેટ્રી ડીશ", "hi": "पेट्री डिश"}'::jsonb, 
  '/assets/images/science/petri_dish.png', 
  '{"en": "This is a Petri Dish. It is a shallow plastic dish used to grow tiny cells.", "gu": "આ પેટ્રી ડીશ છે. તે કોષોના ઉછેર માટે વપરાતી એક સાંકડી પ્લાસ્ટિકની રકાબી છે.", "hi": "यह पेट्री डिश है। यह कोशिकाओं को उगाने के लिए उपयोग की जाने वाली एक उथली प्लास्टिक की डिश है।"}'::jsonb, 
  '{"en": "Scientists fill the petri dish with special nutrient jelly. They place germs on it to watch how they grow and study medicine.", "gu": "વૈજ્ઞાનિકો પેટ્રી ડીશને ખાસ જેલીથી ભરે છે. તેઓ તેના પર જંતુઓ મૂકીને તેના ઉછેર અને દવાઓનો અભ્યાસ કરે છે.", "hi": "वैज्ञानिक पेट्री डिश को एक विशेष जेली से भरते हैं। वे इस पर कीटाणु रखकर उनके विकास और दवाओं का अध्ययन करते हैं।"}'::jsonb, 
  '{"en": "Did you know? Petri dishes are named after Julius Richard Petri, the German assistant who invented them!", "gu": "શું તમે જાણો છો? પેટ્રી ડીશનું નામ તેના શોધક જર્મન વૈજ્ઞાનિક જુલિયસ રિચાર્ડ પેટ્રી પરથી પડ્યું છે!", "hi": "क्या आप जानते हैं? पेट्री डिश का नाम इसके आविष्कारक जर्मन वैज्ञानिक जूलियस रिचर्ड पेट्री के नाम पर रखा गया है!"}'::jsonb, 
  'matching', 
  true, 
  24
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

-- ITEM PIPETTE
INSERT INTO public.science 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'pipette', 
  (SELECT id FROM categories WHERE category_key = 'science' LIMIT 1), 
  '{"en": "Pipette", "gu": "પીપેટ", "hi": "पिपेट"}'::jsonb, 
  '/assets/images/science/pipette.png', 
  '{"en": "This is a Pipette. Pipettes measure and transfer small amounts of liquid carefully.", "gu": "આ પીપેટ છે. પીપેટ પ્રવાહીના નાના જથ્થાને કાળજીપૂર્વક માપે છે અને સ્થાનાંતરિત કરે છે.", "hi": "यह पिपेट है। पिपेट तरल की छोटी मात्रा को सावधानीपूर्वक मापता और स्थानांतरित करता है।"}'::jsonb, 
  '{"en": "A pipette acts like a long straw. Scientists use it to suck up precise amounts of chemicals and drop them into test tubes.", "gu": "પીપેટ એક લાંબી નળી જેવું કામ કરે છે. વૈજ્ઞાનિકો કેમિકલને ચોક્કસ માપમાં લઈને ટેસ્ટ ટ્યુબમાં નાખવા તેનો ઉપયોગ કરે છે.", "hi": "पिपेट एक लंबी नली की तरह काम करता है। वैज्ञानिक रसायनों को सटीक मात्रा में लेकर टेस्ट ट्यूब में डालने के लिए इसका उपयोग करते हैं।"}'::jsonb, 
  '{"en": "Did you know? Some advanced pipettes can measure liquids that are smaller than a single drop of water!", "gu": "શું તમે જાણો છો? કેટલીક અત્યાધુનિક પીપેટ પાણીના એક ટીપાં કરતાં પણ ઓછા પ્રવાહીને માપી શકે છે!", "hi": "क्या आप जानते हैं? कुछ उन्नत पिपेट पानी की एक बूंद से भी कम तरल को माप सकते हैं!"}'::jsonb, 
  'matching', 
  true, 
  25
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

-- ITEM TELESCOPE
INSERT INTO public.science 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'telescope', 
  (SELECT id FROM categories WHERE category_key = 'science' LIMIT 1), 
  '{"en": "Telescope", "gu": "ટેલિસ્કોપ", "hi": "दूरबीन (टेलीस्कोप)"}'::jsonb, 
  '/assets/images/science/telescope.png', 
  '{"en": "This is a Telescope. Telescopes help us see stars and planets far away in space.", "gu": "આ ટેલિસ્કોપ છે. ટેલિસ્કોપ આપણને અંતરિક્ષમાં દૂર આવેલા તારાઓ અને ગ્રહો જોવામાં મદદ કરે છે.", "hi": "यह टेलीस्कोप है। टेलीस्कोप हमें अंतरिक्ष में दूर स्थित तारों और ग्रहों को देखने में मदद करता है।"}'::jsonb, 
  '{"en": "A telescope uses powerful curved mirrors and lenses to capture light from space. It makes the moon, planets, and galaxies look close and clear.", "gu": "ટેલિસ્કોપ અંતરિક્ષમાંથી પ્રકાશ મેળવવા પાવરફુલ લેન્સ અને અરીસા વાપરે છે. તે ચંદ્ર અને ગ્રહોને નજીક અને સ્પષ્ટ બતાવે છે.", "hi": "टेलीस्कोप अंतरिक्ष से प्रकाश प्राप्त करने के लिए शक्तिशाली लेंस और दर्पण का उपयोग करता है। यह चंद्रमा और ग्रहों को स्पष्ट दिखाता है।"}'::jsonb, 
  '{"en": "Did you know? The Hubble Space Telescope floats in space and takes amazing photos of stars without clouds blocking its view!", "gu": "શું તમે જાણો છો? હબલ સ્પેસ ટેલિસ્કોપ અંતરિક્ષમાં તરે છે અને વાદળોના અવરોધ વિના તારાઓના સુંદર ફોટા પાડે છે!", "hi": "क्या आप जानते हैं? हबल स्पेस टेलीस्कोप अंतरिक्ष में तैरता है और बादलों के बिना तारों की सुंदर तस्वीरें लेता है!"}'::jsonb, 
  'matching', 
  true, 
  26
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

-- ITEM TEST TUBE
INSERT INTO public.science 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'test_tube', 
  (SELECT id FROM categories WHERE category_key = 'science' LIMIT 1), 
  '{"en": "Test Tube", "gu": "ટેસ્ટ ટ્યુબ", "hi": "परखनली (टेस्ट ट्यूब)"}'::jsonb, 
  '/assets/images/science/test_tube.png', 
  '{"en": "This is a Test Tube. Test tubes are small glass tubes used to mix chemicals.", "gu": "આ ટેસ્ટ ટ્યુબ છે. ટેસ્ટ ટ્યુબ એ રસાયણો મિક્સ કરવા માટે વપરાતી નાની કાચની નળીઓ છે.", "hi": "यह टेस्ट ट्यूब है। टेस्ट ट्यूब रसायनों को मिलाने के लिए उपयोग की जाने वाली छोटी कांच की नलियाँ होती हैं।"}'::jsonb, 
  '{"en": "A test tube has a rounded bottom and is open at the top. Scientists hold them in racks to mix liquids and watch chemical reactions.", "gu": "ટેસ્ટ ટ્યુબનું તળિયું ગોળ હોય છે અને ઉપરથી ખુલ્લી હોય છે. પ્રતિક્રિયાઓ જોવા માટે વૈજ્ઞાનિકો તેને સ્ટેન્ડમાં રાખે છે.", "hi": "टेस्ट ट्यूब का निचला हिस्सा गोल होता है और ऊपर से खुली होती है। प्रतिक्रियाएं देखने के लिए वैज्ञानिक इन्हें स्टैंड में रखते हैं।"}'::jsonb, 
  '{"en": "Did you know? Test tubes are usually kept in special wooden or plastic racks so they do not roll and break!", "gu": "શું તમે જાણો છો? ટેસ્ટ ટ્યુબને ગબડીને તૂટી ન જાય તે માટે ખાસ સ્ટેન્ડમાં રાખવામાં આવે છે!", "hi": "क्या आप जानते हैं? टेस्ट ट्यूब को टूटने से बचाने के लिए विशेष स्टैंड में रखा जाता है ताकि वे लुढ़कें नहीं!"}'::jsonb, 
  'matching', 
  true, 
  27
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

-- ITEM THERMOMETER
INSERT INTO public.science 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'thermometer', 
  (SELECT id FROM categories WHERE category_key = 'science' LIMIT 1), 
  '{"en": "Thermometer", "gu": "થર્મોમીટર", "hi": "थर्मामीटर"}'::jsonb, 
  '/assets/images/science/thermometer.png', 
  '{"en": "This is a Thermometer. Thermometers measure how hot or cold something is.", "gu": "આ થર્મોમીટર છે. થર્મોમીટર કોઈ વસ્તુ કેટલી ગરમ કે ઠંડી છે તે માપે છે.", "hi": "यह थर्मामीटर है। थर्मामीटर मापता है कि कोई चीज़ कितनी गर्म या ठंडी है।"}'::jsonb, 
  '{"en": "A thermometer shows temperature in degrees. Doctors use it to check if we have a fever, and we use it to see if it is hot outside.", "gu": "થર્મોમીટર ડિગ્રીમાં તાપમાન દર્શાવે છે. ડોકટરો તાવ માપવા માટે તેનો ઉપયોગ કરે છે અને વાતાવરણનું તાપમાન જોવા માટે પણ તે વપરાય છે.", "hi": "थर्मामीटर डिग्री में तापमान दिखाता है। डॉक्टर बुखार मापने के लिए इसका उपयोग करते हैं और मौसम का तापमान देखने के लिए भी यह उपयोग होता है।"}'::jsonb, 
  '{"en": "Did you know? The first thermometer was created by Galileo Galilei over 400 years ago!", "gu": "શું તમે જાણો છો? પ્રથમ થર્મોમીટરની શોધ ૪૦૦ વર્ષ પહેલાં ગેલિલિયો ગેલિલી દ્વારા કરવામાં આવી હતી!", "hi": "क्या आप जानते हैं? पहले थर्मामीटर का आविष्कार 400 साल पहले गैलीलियो गैलीली द्वारा किया गया था!"}'::jsonb, 
  'matching', 
  true, 
  28
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

-- ITEM VOLCANO
INSERT INTO public.science 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'volcano', 
  (SELECT id FROM categories WHERE category_key = 'science' LIMIT 1), 
  '{"en": "Volcano", "gu": "જ્વાળામુખી", "hi": "ज्वालामुखी"}'::jsonb, 
  '/assets/images/science/volcano.png', 
  '{"en": "This is a Volcano. A volcano is a mountain that can erupt with hot lava.", "gu": "આ જ્વાળામુખી છે. જ્વાળામુખી એક પર્વત છે જેમાંથી ગરમ લાવા બહાર નીકળી શકે છે.", "hi": "यह ज्वालामुखी है। ज्वालामुखी एक पहाड़ होता है जिससे गर्म लावा बाहर निकल सकता है।"}'::jsonb, 
  '{"en": "Underground rock gets so hot it melts into liquid magma. When a volcano erupts, the magma pushes out of the top and becomes red hot lava.", "gu": "જમીનની અંદર રહેલો પથ્થર એટલો ગરમ થાય છે કે તે પીગળી જાય છે. જ્વાળામુખી ફાટે ત્યારે તે ગરમ લાવા તરીકે બહાર આવે છે.", "hi": "जमीन के अंदर का पत्थर इतना गर्म हो जाता है कि वह पिघल जाता है। जब ज्वालामुखी फटता है, तो वह गर्म लावे के रूप में बाहर आता है।"}'::jsonb, 
  '{"en": "Did you know? The largest active volcano in our solar system is actually on Mars, and it is three times taller than Mount Everest!", "gu": "શું તમે જાણો છો? આપણા સૌરમંડળનો સૌથી મોટો સક્રિય જ્વાળામુખી મંગળ ગ્રહ પર આવેલો છે!", "hi": "क्या आप जानते हैं? हमारे सौरमंडल का सबसे बड़ा सक्रिय ज्वालामुखी वास्तव में मंगल ग्रह पर स्थित है!"}'::jsonb, 
  'matching', 
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
