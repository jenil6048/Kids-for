-- 1. Create vehicles table and index
CREATE TABLE IF NOT EXISTS public.vehicles (
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
  constraint vehicles_pkey primary key (id),
  constraint vehicles_topic_key_key unique (topic_key),
  constraint vehicles_category_id_fkey foreign KEY (category_id) references categories (id) on delete CASCADE
) TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS idx_vehicles_topic_key on public.vehicles using btree (topic_key) TABLESPACE pg_default;

-- Disable Row Level Security (RLS) to fix private table access issues
ALTER TABLE public.vehicles DISABLE ROW LEVEL SECURITY;

-- Grant permissions to anonymous client keys
GRANT ALL ON public.vehicles TO anon;
GRANT ALL ON public.vehicles TO authenticated;
GRANT ALL ON public.vehicles TO service_role;

-- 2. Populate vehicles table with 30 vehicles data
-- Using matching as the primary game type

-- VEHICLE AIRPLANE
INSERT INTO public.vehicles 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'airplane', 
  (SELECT id FROM categories WHERE category_key = 'vehicles' LIMIT 1), 
  '{"en": "Airplane", "gu": "વિમાન", "hi": "हवाई जहाज़"}'::jsonb, 
  '/assets/images/vehicles/airplane.png', 
  '{"en": "This is an Airplane. Airplanes fly high in the sky like big metal birds.", "gu": "આ વિમાન છે. વિમાન આકાશમાં ખૂબ ઊંચે ઉડે છે જેમ કે મોટું લોખંડનું પક્ષી.", "hi": "यह हवाई जहाज़ है। हवाई जहाज़ आकाश में बहुत ऊंचे उड़ते हैं जैसे कोई बड़ा लोहे का पक्षी।"}'::jsonb, 
  '{"en": "Airplanes have wings and engines that help them fly very fast. They carry people to far away countries. Pilots fly airplanes.", "gu": "વિમાનને પાંખો અને એન્જિન હોય છે જે તેમને ખૂબ ઝડપથી ઉડવામાં મદદ કરે છે. તેઓ લોકોને દૂરના દેશોમાં લઈ જાય છે. પાયલોટ વિમાન ઉડાવે છે.", "hi": "हवाई जहाज़ों में पंख और इंजन होते हैं जो उन्हें बहुत तेज़ उड़ने में मदद करते हैं। वे लोगों को दूर देशों में ले जाते हैं। पायलट हवाई जहाज़ उड़ाते हैं।"}'::jsonb, 
  '{"en": "Did you know? The first airplane flight lasted only 12 seconds!", "gu": "શું તમે જાણો છો? પ્રથમ વિમાનની ઉડાન માત્ર ૧૨ સેકન્ડ માટે જ ચાલી હતી!", "hi": "क्या आप जानते हैं? पहली हवाई जहाज़ की उड़ान केवल 12 सेकंड तक चली थी!"}'::jsonb, 
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

-- VEHICLE AMBULANCE
INSERT INTO public.vehicles 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ambulance', 
  (SELECT id FROM categories WHERE category_key = 'vehicles' LIMIT 1), 
  '{"en": "Ambulance", "gu": "એમ્બ્યુલન્સ", "hi": "एम्बुलेंस"}'::jsonb, 
  '/assets/images/vehicles/ambulance.png', 
  '{"en": "This is an Ambulance. Ambulances help sick people get to the hospital quickly.", "gu": "આ એમ્બ્યુલન્સ છે. એમ્બ્યુલન્સ બીમાર લોકોને ઝડપથી હોસ્પિટલ પહોંચવામાં મદદ કરે છે.", "hi": "यह एम्बुलेंस है। एम्बुलेंस बीमार लोगों को जल्दी से अस्पताल पहुँचाने में मदद करती है।"}'::jsonb, 
  '{"en": "Ambulances have bright flashing lights and a loud siren so other cars let them pass. Doctors and paramedics help people inside.", "gu": "એમ્બ્યુલન્સમાં તેજસ્વી લાલ-વાદળી લાઇટો અને મોટો સાયરન અવાજ હોય છે જેથી અન્ય ગાડીઓ તેમને રસ્તો આપે. ડોક્ટરો અંદર દર્દીની મદદ કરે છે.", "hi": "एम्बुलेंस में चमकीली लाइटें और तेज़ साइरन होता है ताकि दूसरी गाड़ियाँ उन्हें रास्ता दे सकें। डॉक्टर और स्वास्थ्य कर्मी अंदर लोगों की मदद करते हैं।"}'::jsonb, 
  '{"en": "Did you know? The siren of an ambulance can be heard from very far away!", "gu": "શું તમે જાણો છો? એમ્બ્યુલન્સનો સાયરન ખૂબ જ દૂરથી પણ સાંભળી શકાય છે!", "hi": "क्या आप जानते हैं? एम्बुलेंस का साइरन बहुत दूर से भी सुना जा सकता है!"}'::jsonb, 
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

-- VEHICLE BICYCLE
INSERT INTO public.vehicles 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'bicycle', 
  (SELECT id FROM categories WHERE category_key = 'vehicles' LIMIT 1), 
  '{"en": "Bicycle", "gu": "સાયકલ", "hi": "साइइकिल"}'::jsonb, 
  '/assets/images/vehicles/bicycle.png', 
  '{"en": "This is a Bicycle. Bicycles have two wheels and you pedal them with your feet.", "gu": "આ સાયકલ છે. સાયકલને બે પૈડાં હોય છે અને તમે તેને તમારા પગથી પેડલ મારો છો.", "hi": "यह साइइकिल है। साइइकिल में दो पहिये होते हैं और आप उन्हें अपने पैरों से पैडल मारते हैं।"}'::jsonb, 
  '{"en": "Riding a bicycle is great exercise and lots of fun. You should always wear a helmet to stay safe while riding.", "gu": "સાયકલ ચલાવવી એ એક ઉત્તમ કસરત છે અને ખૂબ જ મજાની પ્રવૃત્તિ છે. સાયકલ ચલાવતી વખતે તમારે હંમેશા હેલ્મેટ પહેરવું જોઈએ.", "hi": "साइइकिल चलाना एक बेहतरीन व्यायाम है और बहुत ही मजेदार है। सवारी करते समय सुरक्षित रहने के लिए आपको हमेशा हेलमेट पहनना चाहिए।"}'::jsonb, 
  '{"en": "Did you know? There are more than one billion bicycles in the world, which is double the number of cars!", "gu": "શું તમે જાણો છો? દુનિયામાં એક અબજથી વધુ સાયકલ છે, જે કારની સંખ્યા કરતા બમણી છે!", "hi": "क्या आप जानते हैं? दुनिया में एक अरब से अधिक साइइकिलें हैं, जो कारों की संख्या से दोगुनी है!"}'::jsonb, 
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

-- VEHICLE BULLDOZER
INSERT INTO public.vehicles 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'bulldozer', 
  (SELECT id FROM categories WHERE category_key = 'vehicles' LIMIT 1), 
  '{"en": "Bulldozer", "gu": "બુલડોઝર", "hi": "बुलडोज़र"}'::jsonb, 
  '/assets/images/vehicles/bulldozer.png', 
  '{"en": "This is a Bulldozer. Bulldozers are heavy machines that push dirt and rocks.", "gu": "આ બુલડોઝર છે. બુલડોઝર એ ભારે મશીનો છે જે માટી અને પથ્થરોને ધકેલે છે.", "hi": "यह बुलडोज़र है। बुलडोज़र भारी मशीनें होती हैं जो मिट्टी और पत्थरों को धकेलती हैं।"}'::jsonb, 
  '{"en": "Bulldozers have a big metal blade in the front. They help clear the ground so workers can build houses and roads.", "gu": "બુલડોઝરની આગળ એક મોટું લોખંડનું પાટિયું (બ્લેડ) હોય છે. તેઓ જમીનને સાફ કરવામાં મદદ કરે છે જેથી મકાનો અને રસ્તા બનાવી શકાય.", "hi": "बुलडोज़र के आगे एक बड़ा धातु का ब्लेड होता है। वे ज़मीन को साफ़ करने में मदद करते हैं ताकि मकान और सड़कें बनाई जा सकें।"}'::jsonb, 
  '{"en": "Did you know? The word ''bulldozer'' originally referred to a person who was very strong and pushy!", "gu": "શું તમે જાણો છો? ''બુલડોઝર'' શબ્દ મૂળરૂપે એવા વ્યક્તિ માટે વપરાતો હતો જે ખૂબ મજબૂત અને દબાણ કરનાર હોય!", "hi": "क्या आप जानते हैं? ''बुलडोज़र'' शब्द का इस्तेमाल मूल रूप से उस व्यक्ति के लिए किया जाता था जो बहुत शक्तिशाली और हठी हो!"}'::jsonb, 
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

-- VEHICLE BUS
INSERT INTO public.vehicles 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'bus', 
  (SELECT id FROM categories WHERE category_key = 'vehicles' LIMIT 1), 
  '{"en": "Bus", "gu": "બસ", "hi": "बस"}'::jsonb, 
  '/assets/images/vehicles/bus.png', 
  '{"en": "This is a Bus. Buses are long vehicles that carry many passengers together.", "gu": "આ બસ છે. બસ એ લાંબા વાહનો છે જે ઘણા મુસાફરોને એકસાથે લઈ જાય છે.", "hi": "यह बस है। बसें लंबी गाड़ियाँ होती हैं जो कई यात्रियों को एक साथ ले जाती हैं।"}'::jsonb, 
  '{"en": "Buses stop at bus stops to let people get on and off. Taking a bus helps reduce traffic on the road.", "gu": "લોકોને ચડવા અને ઉતરવા માટે બસો બસ સ્ટેન્ડ પર ઉભી રહે છે. બસમાં મુસાફરી કરવાથી રસ્તા પરનો ટ્રાફિક ઓછો થાય છે.", "hi": "बसें लोगों को चढ़ाने और उतारने के लिए बस स्टॉप पर रुकती हैं। बस से यात्रा करने पर सड़क पर ट्रैफिक कम होता है।"}'::jsonb, 
  '{"en": "Did you know? The first buses were pulled by horses over 190 years ago!", "gu": "શું તમે જાણો છો? ૧૯૦ વર્ષ પહેલાં પ્રથમ બસોને ઘોડાઓ દ્વારા ખેંચવામાં આવતી હતી!", "hi": "क्या आप जानते हैं? 190 साल पहले पहली बसों को घोड़ों द्वारा खींचा जाता था!"}'::jsonb, 
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

-- VEHICLE CANOE
INSERT INTO public.vehicles 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'canoe', 
  (SELECT id FROM categories WHERE category_key = 'vehicles' LIMIT 1), 
  '{"en": "Canoe", "gu": "કેનો", "hi": "कैनो"}'::jsonb, 
  '/assets/images/vehicles/canoe.png', 
  '{"en": "This is a Canoe. A canoe is a narrow boat that you paddle in lakes and rivers.", "gu": "આ કેનો છે. કેનો એ સાંકડી હોડી છે જેને તમે તળાવો અને નદીઓમાં હલેસા મારીને ચલાવો છો.", "hi": "यह कैनो है। कैनो एक संकीर्ण नाव है जिसे आप झीलों और नदियों में पतवार से चलाते हैं।"}'::jsonb, 
  '{"en": "You sit inside a canoe and use paddles to move forward in the water. It is very quiet and peaceful to ride.", "gu": "તમે કેનોની અંદર બેસો છો અને પાણીમાં આગળ વધવા માટે હલેસાનો ઉપયોગ કરો છો. તેની સવારી ખૂબ જ શાંત અને શાંતિદાયક હોય છે.", "hi": "आप कैनो के अंदर बैठते हैं और पानी में आगे बढ़ने के लिए पतवार का उपयोग करते हैं। इसकी सवारी बहुत शांत और शांतिपूर्ण होती है।"}'::jsonb, 
  '{"en": "Did you know? Traditional canoes were carved out of a single large tree trunk!", "gu": "શું તમે જાણો છો? પરંપરાગત કેનોને એક જ મોટા ઝાડના થડમાંથી કોતરીને બનાવવામાં આવતી હતી!", "hi": "क्या आप जानते हैं? पारंपरिक कैनो को एक ही बड़े पेड़ के तने को तराश कर बनाया जाता था!"}'::jsonb, 
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

-- VEHICLE CAR
INSERT INTO public.vehicles 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'car', 
  (SELECT id FROM categories WHERE category_key = 'vehicles' LIMIT 1), 
  '{"en": "Car", "gu": "ગાડી", "hi": "कार"}'::jsonb, 
  '/assets/images/vehicles/car.png', 
  '{"en": "This is a Car. Cars have four wheels and carry families on roads.", "gu": "આ ગાડી છે. ગાડીઓને ચાર પૈડાં હોય છે અને તે પરિવારોને રસ્તા પર લઈ જાય છે.", "hi": "यह कार है। कारों में चार पहिये होते हैं और वे परिवारों को सड़कों पर ले जाती हैं।"}'::jsonb, 
  '{"en": "Cars use fuel or electricity to run. We must always wear seatbelts inside a car to stay safe.", "gu": "ગાડીઓ ચલાવવા માટે ઇંધણ અથવા વીજળીનો ઉપયોગ થાય છે. સુરક્ષિત રહેવા માટે આપણે હંમેશા ગાડીની અંદર સીટબેલ્ટ બાંધવો જોઈએ.", "hi": "कारें चलने के लिए ईंधन या बिजली का उपयोग करती हैं। सुरक्षित रहने के लिए हमें हमेशा कार के अंदर सीट बेल्ट पहननी चाहिए।"}'::jsonb, 
  '{"en": "Did you know? The first cars did not have steering wheels; they were steered with levers!", "gu": "શું તમે જાણો છો? પ્રથમ ગાડીઓમાં સ્ટીયરીંગ વ્હીલ નહોતા; તેમને લીવર વડે ચલાવવામાં આવતી હતી!", "hi": "क्या आप जानते हैं? पहली कारों में स्टीयरिंग व्हील नहीं होते थे; उन्हें लीवर से चलाया जाता था!"}'::jsonb, 
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

-- VEHICLE CEMENT MIXER
INSERT INTO public.vehicles 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'cement_mixer', 
  (SELECT id FROM categories WHERE category_key = 'vehicles' LIMIT 1), 
  '{"en": "Cement Mixer", "gu": "સિમેન્ટ મિક્સર", "hi": "सीमेंट मिक्सर"}'::jsonb, 
  '/assets/images/vehicles/cement_mixer.png', 
  '{"en": "This is a Cement Mixer. It is a big truck with a drum that spins round and round.", "gu": "આ સિમેન્ટ મિક્સર છે. તે એક મોટો ટ્રક છે જેમાં એક ડ્રમ ગોળ ગોળ ફરે છે.", "hi": "यह सीमेंट मिक्सर है। यह एक बड़ा ट्रक होता है जिसमें एक ड्रम गोल-गोल घूमता है।"}'::jsonb, 
  '{"en": "The spinning drum mixes sand, water, and stones to make wet cement. It must keep spinning so the cement does not get hard.", "gu": "ગોળ ફરતું ડ્રમ ભીનો સિમેન્ટ બનાવવા માટે રેતી, પાણી અને પત્થરોને મિશ્રિત કરે છે. સિમેન્ટ કઠણ ન થઈ જાય તે માટે તેને ફરતું રાખવું પડે છે.", "hi": "घूमता हुआ ड्रम गीला सीमेंट बनाने के लिए रेत, पानी और पत्थरों को मिलाता है। सीमेंट सख्त न हो जाए, इसके लिए इसे लगातार घूमते रहना पड़ता है।"}'::jsonb, 
  '{"en": "Did you know? Cement mixers have a special chute at the back to pour out the cement exactly where it is needed!", "gu": "શું તમે જાણો છો? સિમેન્ટ મિક્સરમાં પાછળના ભાગમાં એક ખાસ નળી હોય છે જેનાથી સિમેન્ટને બરાબર જોઈતી જગ્યાએ ઠાલવી શકાય છે!", "hi": "क्या आप जानते हैं? सीमेंट मिक्सर के पीछे एक विशेष पाइप होता है जिससे सीमेंट को ठीक उसी जगह डाला जा सकता है जहाँ उसकी ज़रूरत हो!"}'::jsonb, 
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

-- VEHICLE CRANE
INSERT INTO public.vehicles 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'crane', 
  (SELECT id FROM categories WHERE category_key = 'vehicles' LIMIT 1), 
  '{"en": "Crane", "gu": "ક્રેન", "hi": "क्रेन"}'::jsonb, 
  '/assets/images/vehicles/crane.png', 
  '{"en": "This is a Crane. Cranes are tall machines that lift very heavy things.", "gu": "આ ક્રેન છે. ક્રેન એ ઊંચા મશીનો છે જે ખૂબ જ ભારે વસ્તુઓને ઉંચકે છે.", "hi": "यह क्रेन है। क्रेन लंबी मशीनें होती हैं जो बहुत भारी चीजों को उठाती हैं।"}'::jsonb, 
  '{"en": "Cranes use a long arm, ropes, and a hook to lift materials high into the air. They are used at construction sites to build tall buildings.", "gu": "ક્રેન સામગ્રીને હવામાં ઊંચે લઈ જવા માટે લાંબા હાથ, દોરડા અને હૂકનો ઉપયોગ કરે છે. તેનો ઉપયોગ ઊંચી ઇમારતો બનાવવા માટે થાય છે.", "hi": "क्रेन सामग्री को हवा में ऊंचा उठाने के लिए एक लंबे हाथ, रस्सियों और एक हुक का उपयोग करती है। इनका उपयोग निर्माण स्थलों पर ऊंची इमारतें बनाने के लिए किया जाता है।"}'::jsonb, 
  '{"en": "Did you know? The crane machine is named after the crane bird because they both have long, thin necks!", "gu": "શું તમે જાણો છો? ક્રેન મશીનનું નામ ક્રેન (સારસ) પક્ષી પરથી પડ્યું છે કારણ કે બંનેને લાંબી અને પાતળી ડોક હોય છે!", "hi": "क्या आप जानते हैं? क्रेन मशीन का नाम क्रेन (सारस) पक्षी के नाम पर रखा गया है क्योंकि दोनों की गर्दन लंबी और पतली होती है!"}'::jsonb, 
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

-- VEHICLE CRUISE SHIP
INSERT INTO public.vehicles 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'cruise_ship', 
  (SELECT id FROM categories WHERE category_key = 'vehicles' LIMIT 1), 
  '{"en": "Cruise Ship", "gu": "ક્રુઝ શિપ", "hi": "क्रूज़ जहाज"}'::jsonb, 
  '/assets/images/vehicles/cruise_ship.png', 
  '{"en": "This is a Cruise Ship. Cruise ships are like floating hotels that travel across the ocean.", "gu": "આ ક્રુઝ શિપ છે. ક્રુઝ શિપ એ પાણી પર તરતી હોટેલ જેવી હોય છે જે સમુદ્રમાં મુસાફરી કરે છે.", "hi": "यह क्रूज़ जहाज है। क्रूज़ जहाज पानी पर तैरते हुए होटल की तरह होते हैं जो समुद्र में यात्रा करते हैं।"}'::jsonb, 
  '{"en": "Cruise ships carry thousands of people on vacation. They have pools, restaurants, and play areas inside. They travel slowly from city to city.", "gu": "ક્રુઝ શિપ હજારો લોકોને રજાઓ ગાળવા લઈ જાય છે. તેમની અંદર સ્વિમિંગ પૂલ, રેસ્ટોરન્ટ અને રમવાની જગ્યાઓ હોય છે. તેઓ એક શહેરથી બીજા શહેર ધીમેથી મુસાફરી કરે છે.", "hi": "क्रूज़ जहाज हजारों लोगों को छुट्टियों पर ले जाते हैं। उनके अंदर स्विमिंग पूल, रेस्तरां और खेलने के क्षेत्र होते हैं। वे एक शहर से दूसरे शहर धीरे-धीरे यात्रा करते हैं।"}'::jsonb, 
  '{"en": "Did you know? Some giant cruise ships are longer than three football fields placed end-to-end!", "gu": "શું તમે જાણો છો? કેટલાક વિશાળ ક્રુઝ શિપ ત્રણ ફૂટબોલ મેદાન એકસાથે રાખીએ તેનાથી પણ લાંબા હોય છે!", "hi": "क्या आप जानते हैं? कुछ विशाल क्रूज़ जहाज तीन फुटबॉल मैदानों से भी अधिक लंबे होते हैं!"}'::jsonb, 
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

-- VEHICLE EXCAVATOR
INSERT INTO public.vehicles 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'excavator', 
  (SELECT id FROM categories WHERE category_key = 'vehicles' LIMIT 1), 
  '{"en": "Excavator", "gu": "એક્સ્કેવેટર", "hi": "उत्खनक (एक्स्कवेटर)"}'::jsonb, 
  '/assets/images/vehicles/excavator.png', 
  '{"en": "This is an Excavator. Excavators have a big bucket arm to dig deep holes in the ground.", "gu": "આ એક્સ્કેવેટર છે. એક્સ્કેવેટર પાસે જમીનમાં ઊંડા ખાડા ખોદવા માટે એક મોટો હાથ હોય છે.", "hi": "यह एक्स्कवेटर है। एक्स्कवेटर के पास जमीन में गहरे गड्ढे खोदने के लिए एक बड़ा हाथ होता है।"}'::jsonb, 
  '{"en": "Excavators rotate all the way around. They scoop up dirt, rocks, and sand, then dump them into dump trucks. They are very strong builders.", "gu": "એક્સ્કેવેટર આખું ગોળ ફરી શકે છે. તેઓ માટી, પત્થરો અને રેતીને ખોદીને ડમ્પ ટ્રકમાં ઠાલવે છે. તેઓ ખૂબ જ શક્તિશાળી મશીન છે.", "hi": "एक्स्कवेटर चारों ओर घूम सकते हैं। वे मिट्टी, पत्थरों और रेत को खोदकर डंप ट्रक में डालते हैं। वे बहुत शक्तिशाली मशीनें होती हैं।"}'::jsonb, 
  '{"en": "Did you know? Excavators move on special tracks instead of wheels so they do not get stuck in muddy dirt!", "gu": "શું તમે જાણો છો? એક્સ્કેવેટર વ્હીલ્સને બદલે ખાસ ટ્રેક (પટ્ટા) પર ચાલે છે જેથી તેઓ કાદવવાળી માટીમાં ફસાઈ ન જાય!", "hi": "क्या आप जानते हैं? एक्स्कवेटर पहियों के बजाय विशेष ट्रैक पर चलते हैं ताकि वे कीचड़ वाली मिट्टी में न फंसें!"}'::jsonb, 
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

-- VEHICLE FIRE TRUCK
INSERT INTO public.vehicles 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'fire_truck', 
  (SELECT id FROM categories WHERE category_key = 'vehicles' LIMIT 1), 
  '{"en": "Fire Truck", "gu": "ફાયર ટ્રક", "hi": "दमकल (फायर ट्रक)"}'::jsonb, 
  '/assets/images/vehicles/fire_truck.png', 
  '{"en": "This is a Fire Truck. Fire trucks are big red trucks that help put out fires.", "gu": "આ ફાયર ટ્રક છે. ફાયર ટ્રક એ મોટા લાલ ટ્રક છે જે આગ ઓલવવામાં મદદ કરે છે.", "hi": "यह दमकल है। दमकल बड़ी लाल गाड़ियाँ होती हैं जो आग बुझाने में मदद करती हैं।"}'::jsonb, 
  '{"en": "Fire trucks carry long ladders, water hoses, and brave firefighters. They sound their sirens to rush to emergencies.", "gu": "ફાયર ટ્રકમાં લાંબી નિસરણી, પાણીની પાઈપો અને બહાદુર અગ્નિશામકો (ફાયર ફાઇટર્સ) હોય છે. તેઓ કટોકટીમાં ઝડપથી જવા માટે સાયરન વગાડે છે.", "hi": "दमकल में लंबी सीढ़ियाँ, पानी के पाइप और बहादुर दमकलकर्मी होते हैं। वे आपातकाल में तेजी से जाने के लिए साइरन बजाते हैं।"}'::jsonb, 
  '{"en": "Did you know? Some fire trucks can hold more than 1,000 gallons of water in their tanks!", "gu": "શું તમે જાણો છો? કેટલાક ફાયર ટ્રકની ટાંકીમાં ૧,૦૦૦ ગેલનથી વધુ પાણી સમાઈ શકે છે!", "hi": "क्या आप जानते हैं? कुछ दमकल गाड़ियों की टंकी में 1,000 गैलन से अधिक पानी आ सकता है!"}'::jsonb, 
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

-- VEHICLE FORKLIFT
INSERT INTO public.vehicles 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'forklift', 
  (SELECT id FROM categories WHERE category_key = 'vehicles' LIMIT 1), 
  '{"en": "Forklift", "gu": "ફોર્કલિફ્ટ", "hi": "फ़ोर्कलिफ़्ट"}'::jsonb, 
  '/assets/images/vehicles/forklift.png', 
  '{"en": "This is a Forklift. Forklifts are small vehicles used to lift and move heavy boxes.", "gu": "આ ફોર્કલિફ્ટ છે. ફોર્કલિફ્ટ એ નાની ગાડીઓ છે જેનો ઉપયોગ ભારે બોક્સ ઉપાડવા અને ખસેડવા માટે થાય છે.", "hi": "यह फ़ोर्कलिफ़्ट है। फ़ोर्कलिफ़्ट छोटे वाहन होते हैं जिनका उपयोग भारी बक्से उठाने और स्थानांतरित करने के लिए किया जाता है।"}'::jsonb, 
  '{"en": "Forklifts have two metal forks in the front. They slide under boxes, lift them up, and carry them around warehouses and stores.", "gu": "ફોર્કલિફ્ટની આગળ લોખંડના બે ફોર્ક (ચીપિયા) હોય છે. તેઓ બોક્સની નીચે જાય છે, તેને ઉપર ઉઠાવે છે અને મોટો સામાન ખસેડે છે.", "hi": "फ़ोर्कलिफ़्ट के आगे धातु के दो कांटे होते हैं। वे बक्से के नीचे जाते हैं, उन्हें ऊपर उठाते हैं और बड़े सामान को एक जगह से दूसरी जगह ले जाते हैं।"}'::jsonb, 
  '{"en": "Did you know? Forklifts steer using their back wheels instead of their front wheels, which helps them make sharp turns!", "gu": "શું તમે જાણો છો? ફોર્કલિફ્ટ આગળના પૈડાંને બદલે પાછળના પૈડાંથી દિશા બદલે છે, જે તેમને ઝડપી વળાંક લેવામાં મદદ કરે છે!", "hi": "क्या आप जानते हैं? फ़ोर्कलिफ़्ट आगे के पहियों के बजाय पीछे के पहियों से दिशा बदलते हैं, जिससे उन्हें तेजी से मुड़ने में मदद मिलती है!"}'::jsonb, 
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

-- VEHICLE GARBAGE TRUCK
INSERT INTO public.vehicles 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'garbage_truck', 
  (SELECT id FROM categories WHERE category_key = 'vehicles' LIMIT 1), 
  '{"en": "Garbage Truck", "gu": "કચરાની ટ્રક", "hi": "कचरा गाड़ी"}'::jsonb, 
  '/assets/images/vehicles/garbage_truck.png', 
  '{"en": "This is a Garbage Truck. Garbage trucks collect trash from our homes to keep our streets clean.", "gu": "આ કચરાની ટ્રક છે. કચરાની ટ્રક આપણી શેરીઓને સાફ રાખવા માટે ઘરોમાંથી કચરો એકત્રિત કરે છે.", "hi": "यह कचरा गाड़ी है। कचरा गाड़ी हमारी गलियों को साफ़ रखने के लिए घरों से कचरा इकट्ठा करती है।"}'::jsonb, 
  '{"en": "Garbage trucks have a big crusher in the back that squishes the trash so more can fit inside. The sanitation workers drive them.", "gu": "કચરાની ટ્રકની પાછળ એક મોટો ક્રશર (દબાવવાનું મશીન) હોય છે જે કચરાને દબાવી દે છે જેથી વધુ કચરો સમય શકે. સફાઈ કામદારો તેને ચલાવે છે.", "hi": "कचरा गाड़ी के पीछे एक बड़ा क्रशर होता है जो कचरे को दबा देता है ताकि अधिक कचरा समा सके। सफाई कर्मचारी इसे चलाते हैं।"}'::jsonb, 
  '{"en": "Did you know? Some modern garbage trucks have robot arms that reach out and lift trash cans automatically!", "gu": "શું તમે જાણો છો? અમુક આધુનિક કચરાની ટ્રકોમાં રોબોટિક હાથ હોય છે જે કચરાપેટીને આપમેળે ઊંચકી લે છે!", "hi": "क्या आप जानते हैं? कुछ आधुनिक कचरा गाड़ियों में रोबोटिक हाथ होते हैं जो कचरे के डिब्बे को अपने आप उठा लेते हैं!"}'::jsonb, 
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

-- VEHICLE HELICOPTER
INSERT INTO public.vehicles 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'helicopter', 
  (SELECT id FROM categories WHERE category_key = 'vehicles' LIMIT 1), 
  '{"en": "Helicopter", "gu": "હેલિકોપ્ટર", "hi": "हेलीकॉप्टर"}'::jsonb, 
  '/assets/images/vehicles/helicopter.png', 
  '{"en": "This is a Helicopter. Helicopters can fly straight up into the air without needing a runway.", "gu": "આ હેલિકોપ્ટર છે. હેલિકોપ્ટર રનવે વગર સીધા જ હવામાં ઉપર ઉડી શકે છે.", "hi": "यह हेलीकॉप्टर है। हेलीकॉप्टर रनवे के बिना सीधे ही हवा में ऊपर उड़ सकते हैं।"}'::jsonb, 
  '{"en": "Helicopters use spinning blades on top to fly. They can hover in one spot and land in tiny spaces like hospital roofs.", "gu": "હેલિકોપ્ટર ઉડવા માટે ઉપર ગોળ ફરતી બ્લેડનો ઉપયોગ કરે છે. તેઓ એક જગ્યાએ સ્થિર રહી શકે છે અને હોસ્પિટલની છત જેવી નાની જગ્યામાં ઉતરી શકે છે.", "hi": "हेलीकॉप्टर उड़ने के लिए ऊपर घूमने वाले ब्लेड का उपयोग करते हैं। वे एक जगह पर स्थिर रह सकते हैं और अस्पताल की छतों जैसी छोटी जगहों पर उतर सकते हैं।"}'::jsonb, 
  '{"en": "Did you know? Helicopters are often used in rescues because they can reach places where airplanes cannot land!", "gu": "શું તમે જાણો છો? હેલિકોપ્ટરનો ઉપયોગ બચાવ કાર્યમાં થાય છે કારણ કે તેઓ એવી જગ્યાએ પહોંચી શકે છે જ્યાં વિમાન ઉતરી શકતા નથી!", "hi": "क्या आप जानते हैं? हेलीकॉप्टर का उपयोग अक्सर बचाव कार्यों में किया जाता है क्योंकि वे ऐसी जगहों पर पहुँच सकते हैं जहाँ हवाई जहाज़ नहीं उतर सकते!"}'::jsonb, 
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

-- VEHICLE HOT AIR BALLOON
INSERT INTO public.vehicles 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'hot_air_balloon', 
  (SELECT id FROM categories WHERE category_key = 'vehicles' LIMIT 1), 
  '{"en": "Hot Air Balloon", "gu": "ગરમ હવાનો ફુગ્ગો", "hi": "गर्म हवा का गुब्बारा"}'::jsonb, 
  '/assets/images/vehicles/hot_air_balloon.png', 
  '{"en": "This is a Hot Air Balloon. Hot air balloons float gently in the sky using hot air.", "gu": "આ ગરમ હવાનો ફુગ્ગો છે. ગરમ હવાનો ફુગ્ગો ગરમ હવાની મદદથી આકાશમાં ધીમેથી તરે છે.", "hi": "यह गर्म हवा का गुब्बारा है। गर्म हवा का गुब्बारा गर्म हवा की मदद से आसमान में धीरे-धीरे तैरता है।"}'::jsonb, 
  '{"en": "You sit in a wicker basket below a giant colorful balloon. A burner heats the air inside the balloon to make it rise up into the clouds.", "gu": "તમે વિશાળ રંગબેરંગી ફુગ્ગાની નીચે લટકતી વાંસની ટોપલીમાં બેસો છો. ફુગ્ગાની અંદરની હવાને ગરમ કરવામાં આવે છે જેથી તે વાદળોમાં ઉપર જાય છે.", "hi": "आप बड़े रंग-बिरंगे गुब्बारे के नीचे लटकी टोकरी में बैठते हैं। गुब्बारे के अंदर की हवा को गर्म किया जाता है जिससे यह बादलों में ऊपर जाता है।"}'::jsonb, 
  '{"en": "Did you know? The first hot air balloon passengers were a sheep, a duck, and a rooster!", "gu": "શું તમે જાણો છો? ગરમ હવાના ફુગ્ગાના પ્રથમ મુસાફરો એક ઘેટું, એક બતક અને એક મરઘો હતા!", "hi": "क्या आप जानते हैं? गर्म हवा के गुब्बारे के पहले यात्री एक भेड़, एक बत्तख और एक मुर्गा थे!"}'::jsonb, 
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

-- VEHICLE METRO
INSERT INTO public.vehicles 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'metro', 
  (SELECT id FROM categories WHERE category_key = 'vehicles' LIMIT 1), 
  '{"en": "Metro", "gu": "મેટ્રો", "hi": "मेट्रो"}'::jsonb, 
  '/assets/images/vehicles/metro.png', 
  '{"en": "This is a Metro. Metros are fast electric trains that carry people around big cities.", "gu": "આ મેટ્રો છે. મેટ્રો એ ઇલેક્ટ્રિક ટ્રેનો છે જે લોકોને મોટા શહેરોમાં ઝડપથી લઈ જાય છે.", "hi": "यह मेट्रो है। मेट्रो इलेक्ट्रिक ट्रेनें होती हैं जो लोगों को बड़े शहरों में तेज़ी से ले जाती हैं।"}'::jsonb, 
  '{"en": "Metros travel on special tracks, often under the ground in tunnels or high above the streets. They are very fast and never get stuck in traffic.", "gu": "મેટ્રો ખાસ ટ્રેક પર ચાલે છે, ઘણીવાર જમીનની અંદર ટનલમાં અથવા રસ્તાઓથી ખૂબ ઊંચે. તે ખૂબ જ ઝડપી હોય છે અને ક્યારેય ટ્રાફિકમાં ફસાતી નથી.", "hi": "मेट्रो विशेष पटरियों पर चलती है, अक्सर जमीन के नीचे सुरंगों में या सड़कों से बहुत ऊपर। ये बहुत तेज़ होती हैं और कभी ट्रैफिक में नहीं फंसतीं।"}'::jsonb, 
  '{"en": "Did you know? The oldest metro system in the world is in London, built over 160 years ago!", "gu": "શું તમે જાણો છો? દુનિયાની સૌથી જૂની મેટ્રો સિસ્ટમ લંડનમાં છે, જે ૧૬૦ વર્ષ પહેલાં બનાવવામાં આવી હતી!", "hi": "क्या आप जानते हैं? दुनिया की सबसे पुरानी मेट्रो प्रणाली लंदन में है, जिसे 160 साल से पहले बनाया गया था!"}'::jsonb, 
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

-- VEHICLE MOTOR BOAT
INSERT INTO public.vehicles 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'motor_boat', 
  (SELECT id FROM categories WHERE category_key = 'vehicles' LIMIT 1), 
  '{"en": "Motor Boat", "gu": "મોટર બોટ", "hi": "मोटर बोट"}'::jsonb, 
  '/assets/images/vehicles/motor_boat.png', 
  '{"en": "This is a Motor Boat. Motor boats are fast boats powered by a motor engine.", "gu": "આ મોટર બોટ છે. મોટર બોટ એ એન્જિન દ્વારા ચાલતી ખૂબ ઝડપી હોડી છે.", "hi": "यह मोटर बोट है। मोटर बोट इंजन से चलने वाली बहुत तेज़ नाव होती है।"}'::jsonb, 
  '{"en": "Motor boats zoom across the water, creating splashes and waves. People use them for fun, fishing, and traveling across lakes.", "gu": "મોટર બોટ પાણીમાં ઝડપથી આગળ વધે છે, અને મોજા ઉછાળે છે. લોકો તેનો ઉપયોગ મનોરંજન, માછીમારી અને તળાવ પાર કરવા માટે કરે છે.", "hi": "मोटर बोट पानी में तेज़ी से आगे बढ़ती है और लहरें उठाती है। लोग इसका उपयोग मनोरंजन, मछली पकड़ने और झीलों की यात्रा के लिए करते हैं।"}'::jsonb, 
  '{"en": "Did you know? The fastest motor boats can travel faster than most sports cars on land!", "gu": "શું તમે જાણો છો? સૌથી ઝડપી મોટર બોટ જમીન પરની સ્પોર્ટ્સ કાર કરતાં પણ વધુ ઝડપે મુસાફરી કરી શકે છે!", "hi": "क्या आप जानते हैं? सबसे तेज़ मोटर बोट जमीन पर चलने वाली स्पोर्ट्स कार से भी तेज़ गति से चल सकती है!"}'::jsonb, 
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

-- VEHICLE MOTORCYCLE
INSERT INTO public.vehicles 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'motorcycle', 
  (SELECT id FROM categories WHERE category_key = 'vehicles' LIMIT 1), 
  '{"en": "Motorcycle", "gu": "મોટરસાયકલ", "hi": "मोटरसाइकिल"}'::jsonb, 
  '/assets/images/vehicles/motorcycle.png', 
  '{"en": "This is a Motorcycle. Motorcycles are two-wheeled vehicles powered by an engine.", "gu": "આ મોટરસાયકલ છે. મોટરસાયકલ એ એન્જિન દ્વારા ચાલતા બે પૈડાંવાળા વાહનો છે.", "hi": "यह मोटरसाइकिल है। मोटरसाइकिल इंजन से चलने वाले दो पहियों वाले वाहन होते हैं।"}'::jsonb, 
  '{"en": "Motorcycles are fast and exciting to ride. Riders must wear a helmet and protective gear to stay safe on the road.", "gu": "મોટરસાયકલ ચલાવવી ખૂબ જ રોમાંચક છે. રસ્તા પર સુરક્ષિત રહેવા માટે ચાલકે હંમેશા હેલ્મેટ પહેરવું જોઈએ.", "hi": "मोटरसाइकिल चलाना बहुत रोमांचक होता है। सड़क पर सुरक्षित रहने के लिए चालक को हमेशा हेलमेट पहनना चाहिए।"}'::jsonb, 
  '{"en": "Did you know? The first motorcycle was made out of wood in Germany!", "gu": "શું તમે જાણો છો? પ્રથમ મોટરસાયકલ જર્મનીમાં લાકડામાંથી બનાવવામાં આવી હતી!", "hi": "क्या आप जानते हैं? पहली मोटरसाइकिल जर्मनी में लकड़ी से बनाई गई थी!"}'::jsonb, 
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

-- VEHICLE POLICE CAR
INSERT INTO public.vehicles 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'police_car', 
  (SELECT id FROM categories WHERE category_key = 'vehicles' LIMIT 1), 
  '{"en": "Police Car", "gu": "પોલીસ કાર", "hi": "पुलिस की गाड़ी"}'::jsonb, 
  '/assets/images/vehicles/police_car.png', 
  '{"en": "This is a Police Car. Police cars help police officers keep us safe.", "gu": "આ પોલીસ કાર છે. પોલીસ કાર પોલીસ અધિકારીઓને આપણી સુરક્ષા રાખવામાં મદદ કરે છે.", "hi": "यह पुलिस की गाड़ी है। पुलिस की गाड़ी पुलिस अधिकारियों को हमारी सुरक्षा करने में मदद करती है।"}'::jsonb, 
  '{"en": "Police cars have red and blue flashing lights and loud sirens. Officers drive them to help people and patrol the city.", "gu": "પોલીસ કારમાં લાલ અને વાદળી લાઈટો અને મોટા સાયરન હોય છે. પોલીસ અધિકારીઓ તેનો ઉપયોગ પેટ્રોલિંગ માટે કરે છે.", "hi": "पुलिस की गाड़ी में लाल और नीली बत्तियाँ और तेज़ साइरन होता है। पुलिस अधिकारी इसका उपयोग गश्त लगाने के लिए करते हैं।"}'::jsonb, 
  '{"en": "Did you know? Police cars carry special equipment like radios and first-aid kits to help in emergencies!", "gu": "શું તમે જાણો છો? પોલીસ કાર કટોકટીમાં મદદ કરવા માટે રેડિયો અને પ્રાથમિક સારવાર કીટ જેવા સાધનો સાથે રાખે છે!", "hi": "क्या आप जानते हैं? पुलिस की गाड़ी आपातकाल में मदद के लिए वायरलेस रेडियो और प्राथमिक चिकित्सा किट जैसे उपकरण साथ रखती है!"}'::jsonb, 
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

-- VEHICLE ROCKET
INSERT INTO public.vehicles 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'rocket', 
  (SELECT id FROM categories WHERE category_key = 'vehicles' LIMIT 1), 
  '{"en": "Rocket", "gu": "રોકેટ", "hi": "रॉकेट"}'::jsonb, 
  '/assets/images/vehicles/rocket.png', 
  '{"en": "This is a Rocket. Rockets are powerful spacecraft that fly into outer space.", "gu": "આ રોકેટ છે. રોકેટ એ શક્તિશાળી અવકાશયાન છે જે અંતરિક્ષમાં ઉડે છે.", "hi": "यह रॉकेट है। रॉकेट शक्तिशाली अंतरिक्ष यान होते हैं जो अंतरिक्ष में उड़ते हैं।"}'::jsonb, 
  '{"en": "Rockets burn lots of fuel to create a huge blast, pushing them past the clouds and into space. Astronauts ride rockets to go to the moon.", "gu": "રોકેટ હવામાં ખૂબ ઊંચે જવા માટે પુષ્કળ બળતણ વાપરે છે. અવકાશયાત્રીઓ ચંદ્ર પર જવા માટે રોકેટનો ઉપયોગ કરે છે.", "hi": "रॉकेट हवा में बहुत ऊपर जाने के लिए बहुत सारे ईंधन का उपयोग करते हैं। अंतरिक्ष यात्री चंद्रमा पर जाने के लिए रॉकेट का उपयोग करते हैं।"}'::jsonb, 
  '{"en": "Did you know? A rocket needs to travel at 7 miles per second to escape Earth''s gravity!", "gu": "શું તમે જાણો છો? પૃથ્વીના ગુરુત્વાકર્ષણમાંથી બહાર જવા માટે રોકેટને પ્રતિ સેકન્ડ ૭ માઇલની ઝડપે મુસાફરી કરવી પડે છે!", "hi": "क्या आप जानते हैं? पृथ्वी के गुरुत्वाकर्षण से बाहर जाने के लिए रॉकेट को प्रति सेकंड 7 मील की गति से यात्रा करनी पड़ती है!"}'::jsonb, 
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

-- VEHICLE SCHOOL BUS
INSERT INTO public.vehicles 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'school_bus', 
  (SELECT id FROM categories WHERE category_key = 'vehicles' LIMIT 1), 
  '{"en": "School Bus", "gu": "સ્કૂલ બસ", "hi": "स्कूल बस"}'::jsonb, 
  '/assets/images/vehicles/school_bus.png', 
  '{"en": "This is a School Bus. School buses are bright yellow buses that take children to school.", "gu": "આ સ્કૂલ બસ છે. સ્કૂલ બસ એ તેજસ્વી પીળી બસ છે જે બાળકોને શાળાએ લઈ જાય છે.", "hi": "यह स्कूल बस है। स्कूल बस चमकीली पीली बस होती है जो बच्चों को स्कूल ले जाती है।"}'::jsonb, 
  '{"en": "School buses have flashing lights and a stop sign that folds out to make sure children can cross the street safely. They are safe and fun.", "gu": "બાળકો સુરક્ષિત રીતે રસ્તો ઓળંગી શકે તે માટે સ્કૂલ બસમાં ફ્લેશિંગ લાઈટો અને સ્ટોપ સાઈન હોય છે. તેઓ ખૂબ જ સુરક્ષિત છે.", "hi": "बच्चे सुरक्षित रूप से सड़क पार कर सकें, इसके लिए स्कूल बस में फ्लैशिंग लाइटें और स्टॉप साइन होता है। ये बहुत सुरक्षित होती हैं।"}'::jsonb, 
  '{"en": "Did you know? School buses are painted yellow because yellow is the easiest color to see in the morning light!", "gu": "શું તમે જાણો છો? સ્કૂલ બસોને પીળો રંગ કરવામાં આવે છે કારણ કે સવારના પ્રકાશમાં પીળો રંગ સૌથી સરળતાથી જોઈ શકાય છે!", "hi": "क्या आप जानते हैं? स्कूल बसों को पीला रंग दिया जाता है क्योंकि सुबह के उजाले में पीला रंग सबसे आसानी से देखा जा सकता है!"}'::jsonb, 
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

-- VEHICLE SCOOTER
INSERT INTO public.vehicles 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'scooter', 
  (SELECT id FROM categories WHERE category_key = 'vehicles' LIMIT 1), 
  '{"en": "Scooter", "gu": "સ્કૂટર", "hi": "स्कूटर"}'::jsonb, 
  '/assets/images/vehicles/scooter.png', 
  '{"en": "This is a Scooter. Scooters are two-wheeled vehicles with a flat board to stand or sit on.", "gu": "આ સ્કૂટર છે. સ્કૂટર એ ઊભા રહેવા કે બેસવા માટે સપાટ પાટિયું ધરાવતું બે પૈડાંવાળું વાહન છે.", "hi": "यह स्कूटर है। स्कूटर खड़े होने या बैठने के लिए सपाट बोर्ड वाला दो पहियों वाला वाहन होता है।"}'::jsonb, 
  '{"en": "Scooters can be pushed with your feet, or they can have a small engine. They are lightweight and great for short trips.", "gu": "સ્કૂટરને પગથી ધકેલી શકાય છે, અથવા તેમાં નાનું એન્જિન હોય શકે છે. તેઓ હલકા હોય છે અને ટૂંકી મુસાફરી માટે શ્રેષ્ઠ છે.", "hi": "स्कूटर को पैरों से धकेला जा सकता है, या उनमें छोटा इंजन हो सकता है। वे हल्के होते हैं और छोटी यात्राओं के लिए बेहतरीन हैं।"}'::jsonb, 
  '{"en": "Did you know? Electric scooters are very popular today because they are clean and do not produce smoke!", "gu": "શું તમે જાણો છો? ઇલેક્ટ્રિક સ્કૂટર આજે ખૂબ લોકપ્રિય છે કારણ કે તે હવાને પ્રદૂષિત કરતા નથી અને ધુમાડો ઉત્પન્ન કરતા નથી!", "hi": "क्या आप जानते हैं? इलेक्ट्रिक स्कूटर आज बहुत लोकप्रिय हैं क्योंकि वे हवा को प्रदूषित नहीं करते और धुआं पैदा नहीं करते!"}'::jsonb, 
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

-- VEHICLE SEMI TRUCK
INSERT INTO public.vehicles 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'semi_truck', 
  (SELECT id FROM categories WHERE category_key = 'vehicles' LIMIT 1), 
  '{"en": "Semi Truck", "gu": "સેમી ટ્રક", "hi": "सेमी ट्रक"}'::jsonb, 
  '/assets/images/vehicles/semi_truck.png', 
  '{"en": "This is a Semi Truck. Semi trucks are giant trucks that carry goods across the country.", "gu": "આ સેમી ટ્રક છે. સેમી ટ્રક એ વિશાળ ટ્રક છે જે દેશભરમાં માલસામાન લઈ જાય છે.", "hi": "यह सेमी ट्रक है। सेमी ट्रक विशाल ट्रक होते हैं जो देश भर में माल ले जाते हैं।"}'::jsonb, 
  '{"en": "Semi trucks have a powerful cabin in the front and pull a very long trailer at the back. They deliver food, toys, and clothes to stores.", "gu": "સેમી ટ્રકની આગળ એક પાવરફુલ કેબિન હોય છે અને પાછળ એક લાંબુ ટ્રેલર ખેંચે છે. તેઓ દુકાનોમાં ખોરાક, રમકડાં અને કપડાં પહોંચાડે છે.", "hi": "सेमी ट्रक के आगे एक शक्तिशाली केबिन होता है और पीछे एक लंबा ट्रेलर खींचता है। वे दुकानों में भोजन, खिलौने और कपड़े पहुँचाते हैं।"}'::jsonb, 
  '{"en": "Did you know? Semi trucks can have up to 18 wheels to help them carry very heavy loads smoothly!", "gu": "શું તમે જાણો છો? સેમી ટ્રકને ૧૮ જેટલા પૈડા હોઈ શકે છે જે તેમને ભારે સામાન સરળતાથી લઈ જવામાં મદદ કરે છે!", "hi": "क्या आप जानते हैं? सेमी ट्रकों में 18 तक पहिये हो सकते हैं जो उन्हें भारी सामान आसानी से ले जाने में मदद करते हैं!"}'::jsonb, 
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

-- VEHICLE SUBMARINE
INSERT INTO public.vehicles 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'submarine', 
  (SELECT id FROM categories WHERE category_key = 'vehicles' LIMIT 1), 
  '{"en": "Submarine", "gu": "સબમરીન", "hi": "पनडुब्बी"}'::jsonb, 
  '/assets/images/vehicles/submarine.png', 
  '{"en": "This is a Submarine. Submarines are special boats that travel underwater.", "gu": "આ સબમરીન છે. સબમરીન એ ખાસ પ્રકારની હોડી છે જે પાણીની અંદર મુસાફરી કરે છે.", "hi": "यह पनडुब्बी है। पनडुब्बी एक विशेष प्रकार की नाव होती है जो पानी के अंदर यात्रा करती है।"}'::jsonb, 
  '{"en": "Submarines can sink below the ocean and stay underwater for a long time. Sailors use a periscope to see above the water''s surface.", "gu": "સબમરીન પાણીની અંદર ડૂબી શકે છે અને લાંબા સમય સુધી રહી શકે છે. ખલાસીઓ પાણીની સપાટીથી ઉપર જોવા માટે પેરિસ્કોપનો ઉપયોગ કરે છે.", "hi": "पनडुब्बी पानी के अंदर डूब सकती है और लंबे समय तक रह सकती है। नाविक पानी की सतह से ऊपर देखने के लिए पेरिस्कोप का उपयोग करते हैं।"}'::jsonb, 
  '{"en": "Did you know? Submarines use sonar, which is sound waves, to navigate in the dark ocean depths, just like dolphins!", "gu": "શું તમે જાણો છો? સબમરીન અંધારા સમુદ્રમાં રસ્તો શોધવા માટે ડોલ્ફિનની જેમ સોનાર (અવાજના મોજા) નો ઉપયોગ કરે છે!", "hi": "क्या आप जानते हैं? पनडुब्बियां अंधेरे समुद्र में रास्ता खोजने के लिए डॉल्फ़िन की तरह सोनार (ध्वनि तरंगों) का उपयोग करती हैं!"}'::jsonb, 
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

-- VEHICLE TAXI
INSERT INTO public.vehicles 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'taxi', 
  (SELECT id FROM categories WHERE category_key = 'vehicles' LIMIT 1), 
  '{"en": "Taxi", "gu": "ટેક્સી", "hi": "टैक्सी"}'::jsonb, 
  '/assets/images/vehicles/taxi.png', 
  '{"en": "This is a Taxi. Taxis are cars that you pay to take you exactly where you want to go.", "gu": "આ ટેક્સી છે. ટેક્સી એ એવી ગાડી છે જેમાં તમે ભાડું આપીને ગમે ત્યાં જઈ શકો છો.", "hi": "यह टैक्सी है। टैक्सी ऐसी गाड़ी होती है जिसमें आप किराया देकर कहीं भी जा सकते हैं।"}'::jsonb, 
  '{"en": "You wave your hand to stop a taxi. The taxi driver drives you safely and you pay based on how far you travel. They are often yellow.", "gu": "તમે ટેક્સી રોકવા માટે હાથ હલાવો છો. ટેક્સી ડ્રાઈવર તમને સલામત રીતે મુસાફરી કરાવે છે. તેઓ ઘણીવાર પીળા રંગની હોય છે.", "hi": "आप टैक्सी रोकने के लिए हाथ हिलाते हैं। टैक्सी चालक आपको सुरक्षित रूप से यात्रा कराता है। वे अक्सर पीले रंग की होती हैं।"}'::jsonb, 
  '{"en": "Did you know? In London, taxi drivers must pass a test called ''The Knowledge'', memorizing 25,000 streets!", "gu": "શું તમે જાણો છો? લંડનમાં, ટેક્સી ડ્રાઇવરોએ ''ધ નોલેજ'' નામની પરીક્ષા પાસ કરવી પડે છે, જેમાં ૨૫,૦૦૦ શેરીઓ યાદ રાખવાની હોય છે!", "hi": "क्या आप जानते हैं? लंदन में, टैक्सी चालकों को ''द नॉलेज'' नामक परीक्षा पास करनी होती है, जिसमें 25,000 सड़कों को याद रखना होता है!"}'::jsonb, 
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

-- VEHICLE TRACTOR
INSERT INTO public.vehicles 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'tractor', 
  (SELECT id FROM categories WHERE category_key = 'vehicles' LIMIT 1), 
  '{"en": "Tractor", "gu": "ટ્રેક્ટર", "hi": "ट्रैक्टर"}'::jsonb, 
  '/assets/images/vehicles/tractor.png', 
  '{"en": "This is a Tractor. Tractors are strong farm vehicles with very big back wheels.", "gu": "આ ટ્રેક્ટર છે. ટ્રેક્ટર એ ખેતરના મજબૂત વાહનો છે જેમને પાછળના પૈડા ખૂબ મોટા હોય છે.", "hi": "यह ट्रैक्टर है। ट्रैक्टर खेत के मजबूत वाहन होते हैं जिनके पीछे के पहिये बहुत बड़े होते हैं।"}'::jsonb, 
  '{"en": "Tractors pull heavy farming tools to dig soil, plant seeds, and harvest crops. They help farmers do heavy work in the fields easily.", "gu": "ટ્રેક્ટર જમીન ખોદવા, બીજ રોપવા અને પાક લણવા માટે ભારે સાધનો ખેંચે છે. તેઓ ખેડૂતોને ખેતરમાં ભારે કામ કરવામાં મદદ કરે છે.", "hi": "ट्रैक्टर जमीन खोदने, बीज बोने और फसल काटने के लिए भारी उपकरण खींचते हैं। वे किसानों को खेत में भारी काम करने में मदद करते हैं।"}'::jsonb, 
  '{"en": "Did you know? The giant back wheels of a tractor help it drive through deep, sticky mud without getting stuck!", "gu": "શું તમે જાણો છો? ટ્રેક્ટરના પાછળના મોટા પૈડાં તેને કાદવમાં ફસાયા વગર ચાલવામાં મદદ કરે છે!", "hi": "क्या आप जानते हैं? ट्रैक्टर के पीछे के बड़े पहिये उसे कीचड़ में फंसे बिना चलने में मदद करते हैं!"}'::jsonb, 
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

-- VEHICLE TRAIN
INSERT INTO public.vehicles 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'train', 
  (SELECT id FROM categories WHERE category_key = 'vehicles' LIMIT 1), 
  '{"en": "Train", "gu": "ટ્રેન", "hi": "ट्रेन"}'::jsonb, 
  '/assets/images/vehicles/train.png', 
  '{"en": "This is a Train. Trains are long lines of cars that pull cargo and people on metal tracks.", "gu": "આ ટ્રેન છે. ટ્રેન એ લોખંડના પાટા પર ચાલતી ડબ્બાઓની લાંબી હારમાળા છે.", "hi": "यह ट्रेन है। ट्रेन लोहे की पटरियों पर चलने वाले डिब्बों की लंबी कतार होती है।"}'::jsonb, 
  '{"en": "Trains are pulled by a strong engine locomotive at the front. They travel long distances on railways and sound a loud horn.", "gu": "ટ્રેનને આગળ જોડાયેલું એક શક્તિશાળી એન્જિન ખેંચે છે. તેઓ રેલવે પર લાંબી મુસાફરી કરે છે અને મોટો હોર્ન વગાડે છે.", "hi": "ट्रेन को आगे लगा एक शक्तिशाली इंजन खींचता है। वे रेलवे पर लंबी यात्रा करती हैं और तेज़ हॉर्न बजाती हैं।"}'::jsonb, 
  '{"en": "Did you know? The fastest trains in the world use magnets to float above the tracks and can travel at 370 miles per hour!", "gu": "શું તમે જાણો છો? દુનિયાની સૌથી ઝડપી ટ્રેનો પાટા ઉપર તરવા માટે ચુંબકનો ઉપયોગ કરે છે અને તે કલાકના ૩૭૦ માઇલની ઝડપે દોડી શકે છે!", "hi": "क्या आप जानते हैं? दुनिया की सबसे तेज़ ट्रेनें पटरियों के ऊपर तैरने के लिए चुंबक का उपयोग करती हैं और 370 मील प्रति घंटे की गति से दौड़ सकती हैं!"}'::jsonb, 
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

-- VEHICLE TRAM
INSERT INTO public.vehicles 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'tram', 
  (SELECT id FROM categories WHERE category_key = 'vehicles' LIMIT 1), 
  '{"en": "Tram", "gu": "ટ્રામ", "hi": "ट्राम"}'::jsonb, 
  '/assets/images/vehicles/tram.png', 
  '{"en": "This is a Tram. Trams are electric streetcars that travel on tracks built into city roads.", "gu": "આ ટ્રામ છે. ટ્રામ એ ઇલેક્ટ્રિક ગાડીઓ છે જે શહેરના રસ્તાઓ પર બનેલા પાટા પર ચાલે છે.", "hi": "यह ट्राम है। ट्राम इलेक्ट्रिक गाड़ियाँ होती हैं जो शहर की सड़कों पर बनी पटरियों पर चलती हैं।"}'::jsonb, 
  '{"en": "Trams run on electricity from overhead wires. They share the road with cars and stop frequently to let passengers jump on.", "gu": "ટ્રામ ઉપરના વાયરોમાંથી વીજળી મેળવીને ચાલે છે. તેઓ રસ્તા પર અન્ય ગાડીઓ સાથે ચાલે છે અને મુસાફરો માટે વારંવાર ઉભી રહે છે.", "hi": "ट्राम ऊपर के तारों से बिजली लेकर चलती हैं। वे सड़क पर अन्य गाड़ियों के साथ चलती हैं और यात्रियों के लिए अक्सर रुकती हैं।"}'::jsonb, 
  '{"en": "Did you know? Trams are also called streetcars or trolleys, and they are very quiet and clean!", "gu": "શું તમે જાણો છો? ટ્રામને સ્ટ્રીટકાર અથવા ટ્રોલી પણ કહેવામાં આવે છે, અને તે ખૂબ જ શાંત અને સ્વચ્છ હોય છે!", "hi": "क्या आप जानते हैं? ट्राम को स्ट्रीटकार या ट्रॉली भी कहा जाता है, और ये बहुत शांत और स्वच्छ होती हैं!"}'::jsonb, 
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

-- VEHICLE VAN
INSERT INTO public.vehicles 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'van', 
  (SELECT id FROM categories WHERE category_key = 'vehicles' LIMIT 1), 
  '{"en": "Van", "gu": "વેન", "hi": "वैन"}'::jsonb, 
  '/assets/images/vehicles/van.png', 
  '{"en": "This is a Van. Vans are boxy vehicles that are larger than cars, perfect for carrying families and cargo.", "gu": "આ વેન છે. વેન એ કાર કરતાં મોટા ચોરસ આકારના વાહનો છે, જે પરિવારો અને સામાન લઈ જવા માટે યોગ્ય છે.", "hi": "यह वैन है। वैन कार से बड़ी चौकोर आकार की गाड़ियाँ होती हैं, जो परिवारों और सामान ले जाने के लिए उपयुक्त होती हैं।"}'::jsonb, 
  '{"en": "Vans have sliding doors on the side which makes it easy to get inside. They can hold lots of suitcases, pets, and family members.", "gu": "વેનની બાજુમાં સરકતો દરવાજો (સ્લાઇડિંગ ડોર) હોય છે જે અંદર જવાનું સરળ બનાવે છે. તેઓ ઘણા બધા સૂટકેસ અને પરિવારના સભ્યોને સમાવી શકે છે.", "hi": "वैन के किनारे फिसलने वाला दरवाज़ा (स्लाइडिंग डोर) होता है जिससे अंदर जाना आसान होता है। वे बहुत सारे सूटकेस और परिवार के सदस्यों को रख सकते हैं।"}'::jsonb, 
  '{"en": "Did you know? Vans are very popular for camping because they can be turned into little houses on wheels!", "gu": "શું તમે જાણો છો? કેમ્પિંગ માટે વેન ખૂબ જ લોકપ્રિય છે કારણ કે તેમને પૈડાં પરના નાના ઘરમાં ફેરવી શકાય છે!", "hi": "क्या आप जानते हैं? कैंपिंग के लिए वैन बहुत लोकप्रिय हैं क्योंकि उन्हें पहियों वाले छोटे घरों में बदला जा सकता है!"}'::jsonb, 
  'matching', 
  true, 
  30
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;
