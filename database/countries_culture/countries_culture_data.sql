-- 1. Create countries_culture table

CREATE TABLE IF NOT EXISTS public.countries_culture (
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
  constraint countries_culture_pkey primary key (id),
  constraint countries_culture_topic_key_key unique (topic_key),
  constraint countries_culture_category_id_fkey foreign KEY (category_id) references categories (id) on delete CASCADE
) TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS idx_countries_culture_topic_key on public.countries_culture using btree (topic_key) TABLESPACE pg_default;

ALTER TABLE public.countries_culture DISABLE ROW LEVEL SECURITY;

GRANT ALL ON public.countries_culture TO anon;
GRANT ALL ON public.countries_culture TO authenticated;
GRANT ALL ON public.countries_culture TO service_role;


-- Reset sequence to avoid duplicate key errors
SELECT setval(
  pg_get_serial_sequence('public.categories', 'id'),
  COALESCE((SELECT MAX(id) FROM public.categories), 0) + 1,
  false
);

-- 2. Insert category

INSERT INTO public.categories (category_key, title, color, is_premium, group_id, display_order)
VALUES (
  'countries_culture',
  '{"en": "Countries & Culture", "gu": "દેશો અને સંસ્કૃતિ", "hi": "देश और संस्कृति"}'::jsonb,
  '#FF7043',
  false,
  'natures_world',
  21
)
ON CONFLICT (category_key) DO UPDATE SET
  title = EXCLUDED.title,
  color = EXCLUDED.color,
  group_id = EXCLUDED.group_id,
  display_order = EXCLUDED.display_order;


-- 3. Seed data (48 items)

-- ===================== LANDMARKS =====================

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'taj_mahal',
  (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Taj Mahal", "gu": "તાજ મહેલ", "hi": "ताज महल"}'::jsonb,
  'assets/images/countries_culture/taj_mahal.png',
  '{"en": "Taj Mahal! A beautiful white marble palace in India, built with love!", "gu": "તાજ મહેલ! ભારતમાં પ્રેમ વડે બનાવેલ સુંદર સફેદ આરસ-પહાણ મહેલ!", "hi": "ताज महल! भारत में प्यार से बनाया गया एक खूबसूरत सफेद संगमरमर का महल!"}'::jsonb,
  '{"en": "The Taj Mahal is in Agra, India. Emperor Shah Jahan built it in memory of his beloved wife Mumtaz Mahal. It is made of pure white marble and took over 20,000 workers and 22 years to build!", "gu": "તાજ મહેલ ભારતના આગ્રામાં છે. સમ્રાટ શાહ જહાંએ તેની પ્રિય પત્ની મુમતાઝ મહેલની યાદમાં બનાવ્યો. તે શુદ્ધ સફેદ આરસ-પહાણથી બનેલ છે અને 20,000 થી વધુ કારીગરો અને 22 વર્ષ લાગ્યાં!", "hi": "ताज महल भारत के आगरा में है। सम्राट शाहजहां ने इसे अपनी प्रिय पत्नी मुमताज महल की याद में बनवाया था। यह शुद्ध सफेद संगमरमर से बना है और इसे बनाने में 20,000 से अधिक कारीगरों और 22 साल लगे!"}'::jsonb,
  '{"en": "Did you know? The Taj Mahal is one of the Seven Wonders of the World and is visited by about 8 million people every year!", "gu": "શું તમે જાણો છો? તાજ મહેલ વિશ્વના સાત અજાયબોમાંથી એક છે અને દર વર્ષે લગભગ 80 લાખ લોકો તેની મુલાકાત લે છે!", "hi": "क्या आपको पता है? ताज महल दुनिया के सात अजूबों में से एक है और हर साल लगभग 80 लाख लोग इसे देखने आते हैं!"}'::jsonb,
  'memory', true, 1
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'eiffel_tower',
  (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Eiffel Tower", "gu": "આઇફેલ ટાવર", "hi": "एफिल टॉवर"}'::jsonb,
  'assets/images/countries_culture/eiffel_tower.png',
  '{"en": "Eiffel Tower! The tall iron tower of Paris, France — a symbol of love and beauty!", "gu": "આઇફેલ ટાવર! ફ્રાન્સના પેરિસનો ઊંચો લોખંડ ટાવર — પ્રેમ અને સૌંદર્યનું પ્રતીક!", "hi": "एफिल टॉवर! फ्रांस के पेरिस का ऊंचा लोहे का टॉवर — प्यार और सुंदरता का प्रतीक!"}'::jsonb,
  '{"en": "The Eiffel Tower is in Paris, France. It was built in 1889 as the entrance arch for the World''s Fair. Made of iron, it stands 330 meters tall — about as tall as an 81-storey building!", "gu": "આઇફેલ ટાવર ફ્રાન્સના પેરિસમાં છે. તે 1889 માં વર્લ્ડ ફેર ના પ્રવેશ-ઘાટ તરીકે બનાવ્યો. લોખંડ વડે બનેલ, તે 330 મીટર ઊંચો છે — 81 માળની ઇમારત જેટલો ઊંચો!", "hi": "एफिल टॉवर फ्रांस के पेरिस में है। इसे 1889 में विश्व मेले के प्रवेश द्वार के रूप में बनाया गया था। लोहे से बना, यह 330 मीटर ऊंचा है — एक 81 मंजिला इमारत जितना ऊंचा!"}'::jsonb,
  '{"en": "Did you know? The Eiffel Tower grows about 15 cm taller in summer because the iron expands in heat!", "gu": "શું તમે જાણો છો? ઉનાળામાં ગરમીથી લોખંડ ફૂલે છે, તેથી આઇફેલ ટાવર લગભગ 15 સેમી વધુ ઊંચો થઈ જાય છે!", "hi": "क्या आपको पता है? गर्मियों में लोहा गर्मी से फैलता है, इसलिए एफिल टॉवर लगभग 15 सेमी और ऊंचा हो जाता है!"}'::jsonb,
  'memory', true, 2
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'great_wall_of_china',
  (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Great Wall of China", "gu": "ચીનની મહાન દિવાલ", "hi": "चीन की महान दीवार"}'::jsonb,
  'assets/images/countries_culture/great_wall_of_china.png',
  '{"en": "Great Wall of China! The longest wall in the world, stretching across mountains!", "gu": "ચીનની મહાન દિવાલ! પહાડો પર ફેલાયેલ વિશ્વની સૌથી લાંબી દિવાલ!", "hi": "चीन की महान दीवार! पहाड़ों पर फैली दुनिया की सबसे लंबी दीवार!"}'::jsonb,
  '{"en": "The Great Wall of China stretches over 21,000 km across northern China. It was built over many centuries to protect China from invasions. Millions of workers built it using bricks, stones, and even rice flour!", "gu": "ચીનની મહાન દિવાલ ઉત્તર ચીનમાં 21,000 કિ.મી. ઉપર ફેલાયેલ છે. તે ઘણી સદીઓ સુધી ચીનને આક્રમણોથી બચાવવા માટે બનાવવામાં આવી. લાખો કામ-ગારાઓ ઈંટ, પથ્થર અને ચોખાના લોટ વડે બનાવ્યો!", "hi": "चीन की महान दीवार उत्तरी चीन में 21,000 किमी से अधिक फैली है। इसे कई सदियों में चीन को आक्रमणों से बचाने के लिए बनाया गया था। लाखों श्रमिकों ने ईंटों, पत्थरों और यहां तक कि चावल के आटे का उपयोग करके इसे बनाया!"}'::jsonb,
  '{"en": "Did you know? If you lined up all the bricks in the Great Wall, they could circle the Earth over 36 times!", "gu": "શું તમે જાણો છો? મહાન દિવાલ ની બધી ઇંટ ગોઠવો, તો તે પૃથ્વીની 36 વખત પ્રદક્ષિણા કરી શકે!", "hi": "क्या आपको पता है? अगर महान दीवार की सभी ईंटों को एक सीध में रखा जाए, तो वे पृथ्वी की 36 बार परिक्रमा कर सकती हैं!"}'::jsonb,
  'memory', true, 3
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'pyramids_of_giza',
  (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Pyramids of Giza", "gu": "ગીઝાના પિરામિડ", "hi": "गीज़ा के पिरामिड"}'::jsonb,
  'assets/images/countries_culture/pyramids_of_giza.png',
  '{"en": "Pyramids of Giza! Ancient giant stone tombs built by the Egyptians thousands of years ago!", "gu": "ગીઝાના પિરામિડ! હજારો વર્ષ પહેલાં ઈજિપ્તવાસીઓ દ્વારા બનાવેલ પ્રાચીન વિશાળ પથ્થર-સ્મારક!", "hi": "गीज़ा के पिरामिड! हजारों साल पहले मिस्रवासियों द्वारा बनाए गए प्राचीन विशाल पत्थर के मकबरे!"}'::jsonb,
  '{"en": "The Pyramids of Giza in Egypt are among the oldest structures on Earth. They were built as tombs for ancient Egyptian pharaohs (kings). The Great Pyramid was the tallest man-made structure in the world for over 3,800 years!", "gu": "ઇજિપ્તના ગીઝાના પિરામિડ પૃથ્વી પর સૌથી જૂની ઇમારતોમાં છે. તેઓ પ્રાચીન ઇજિપ્તના ફેરોઓ (રાજા) ના ઘઘૂ-ઘર (કબ્ર) તરીકે બાંધ્યા. ભવ્ય પિરામિડ 3800 વર્ષ સુધી દુનિયાનું સૌથી ઊંચું માનવ-નિર્મિત બાંધકામ હતો!", "hi": "मिस्र के गीज़ा के पिरामिड पृथ्वी पर सबसे पुरानी संरचनाओं में से हैं। वे प्राचीन मिस्र के फराओ (राजाओं) के मकबरों के रूप में बनाए गए थे। महान पिरामिड 3,800 से अधिक वर्षों तक दुनिया की सबसे ऊंची मानव-निर्मित संरचना थी!"}'::jsonb,
  '{"en": "Did you know? The Great Pyramid of Giza contains over 2 million stone blocks, each weighing as much as a car!", "gu": "શું તમે જાણો છો? ગીઝાના ભવ્ય પિરામિડમાં 20 લાખ થી વધુ પથ્થર-ઘાણ (block) છે, જે દરેક એક કારના જેટલું ભારે!", "hi": "क्या आपको पता है? गीज़ा के महान पिरामिड में 20 लाख से अधिक पत्थर के खंड हैं, जिनमें से प्रत्येक एक कार जितना भारी है!"}'::jsonb,
  'memory', true, 4
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'big_ben',
  (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Big Ben", "gu": "બિગ બેન", "hi": "बिग बेन"}'::jsonb,
  'assets/images/countries_culture/big_ben.png',
  '{"en": "Big Ben! The famous giant clock tower of London, England!", "gu": "બિગ બેન! ઇંગ્લેન્ડના લંડનનો પ્રખ્યાત વિશાળ ઘડિયાળ-ટાવર!", "hi": "बिग बेन! इंग्लैंड के लंदन का प्रसिद्ध विशाल घड़ी टावर!"}'::jsonb,
  '{"en": "Big Ben is the nickname for the Great Bell inside the Elizabeth Tower in London. It is one of the most famous clocks in the world and chimes every hour. The tower is 96 meters tall!", "gu": "''બિગ બેન'' એ લંડનના એલિઝાબેથ ટાવરમાં ભવ્ય ઘંટ-ઘડિયાળ નું હુલામણું નામ છે. તે વિશ્વના સૌથી પ્રસિદ્ધ ઘડિયાળોમાં છે અને દર કલાકે ટણ-ટણ કરે છે. ટાવર 96 મીટર ઊંચો છે!", "hi": "''बिग बेन'' लंदन में एलिजाबेथ टावर में विशाल घंटे का उपनाम है। यह दुनिया की सबसे प्रसिद्ध घड़ियों में से एक है और हर घंटे बजती है। टावर 96 मीटर ऊंचा है!"}'::jsonb,
  '{"en": "Did you know? ''Big Ben'' actually refers to the bell inside the tower, not the tower itself. The tower is called Elizabeth Tower!", "gu": "શું તમે જાણો છો? ''બિગ બેન'' ખરેખર ટાવરની અંદરના ઘંટ-ઘડિયાળ ને કહે છે, ટાવર ને નહીં. ટાવર ''એલિઝાબેથ ટાવર'' કહેવાય છે!", "hi": "क्या आपको पता है? ''बिग बेन'' वास्तव में टावर के अंदर की घंटी को कहते हैं, खुद टावर को नहीं। टावर को ''एलिजाबेथ टावर'' कहा जाता है!"}'::jsonb,
  'memory', true, 5
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'statue_of_liberty',
  (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Statue of Liberty", "gu": "સ્ટેચ્યુ ઓફ લિબર્ટી", "hi": "स्टैच्यू ऑफ लिबर्टी"}'::jsonb,
  'assets/images/countries_culture/statue_of_liberty.png',
  '{"en": "Statue of Liberty! The giant green lady holding a torch in New York, USA!", "gu": "સ્ટેચ્યુ ઓફ લિબર્ટી! USA ના ન્યૂ યોર્કમાં મશાલ પકડેલ વિશાળ લીલી મૂર્તિ!", "hi": "स्टैच्यू ऑफ लिबर्टी! अमेरिका के न्यूयॉर्क में मशाल थामे विशाल हरी मूर्ति!"}'::jsonb,
  '{"en": "The Statue of Liberty stands on Liberty Island in New York Harbor. It was a gift from France to the United States in 1886. Lady Liberty holds a torch in her right hand and a tablet with the date July 4, 1776 in her left!", "gu": "સ્ટેચ્યુ ઓફ લિબર્ટી ન્યૂ યોર્ક હાર્બરમાં લિબર્ટી ટાપુ ઉપર ઊભી છે. 1886 માં ફ્રાન્સ એ USA ને ભેટ તરીકે આપ્યો. ''લેડી લિબર્ટી'' ઉઘ-હસ્ત-ઘ (right hand) માં મશાલ અને ડ-હસ્ત (left hand) માં 4 જુલાઈ, 1776 ની તારીખ-ઘ (tablet) ધારણ કરે છે!", "hi": "स्टैच्यू ऑफ लिबर्टी न्यूयॉर्क हार्बर में लिबर्टी द्वीप पर खड़ी है। यह 1886 में फ्रांस की ओर से अमेरिका को उपहार थी। ''लेडी लिबर्टी'' अपने दाहिने हाथ में मशाल और बाएं हाथ में 4 जुलाई, 1776 की तारीख वाली पट्टिका धारण करती है!"}'::jsonb,
  '{"en": "Did you know? Lady Liberty''s full name is ''Liberty Enlightening the World'' and her crown has 7 spikes representing the 7 oceans and 7 continents!", "gu": "શું તમે જાણો છો? ''લેડી લિબર્ટી'' નું પૂરું નામ ''Liberty Enlightening the World'' (દુનિયાને પ્રકાશ આપતી સ્વતંત્રતા) છે અને ઘ(crown) ની 7 ટોળ 7 સમુદ્ર અને 7 ખંડ ના પ્રતીક છે!", "hi": "क्या आपको पता है? ''लेडी लिबर्टी'' का पूरा नाम ''Liberty Enlightening the World'' (दुनिया को प्रकाशित करने वाली स्वतंत्रता) है और उसके मुकुट में 7 स्पाइक्स 7 महासागरों और 7 महाद्वीपों का प्रतीक हैं!"}'::jsonb,
  'memory', true, 6
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'sydney_opera_house',
  (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Sydney Opera House", "gu": "સિડની ઓપેરા હાઉસ", "hi": "सिडनी ओपेरा हाउस"}'::jsonb,
  'assets/images/countries_culture/sydney_opera_house.png',
  '{"en": "Sydney Opera House! The shell-shaped concert hall by the sea in Australia!", "gu": "સિડની ઓપેરા હાઉસ! ઓસ્ટ્રેલિયામાં દરિયા-કિનારે શ-ઘ (shell) આકારનો સંગીત-ઘ (concert hall)!", "hi": "सिडनी ओपेरा हाउस! ऑस्ट्रेलिया में समुद्र के किनारे सीप के आकार का कॉन्सर्ट हॉल!"}'::jsonb,
  '{"en": "The Sydney Opera House is in Sydney, Australia. It looks like giant white sails or shells by the sea. It is a UNESCO World Heritage Site and one of the most recognizable buildings on Earth. It hosts over 1,500 performances every year!", "gu": "સિડની ઓપેરા હાઉસ ઓસ્ટ્રેલિયાના સિડનીમાં છે. તે સમુદ્ર-કિનારે વિશાળ સફેદ ઘ (sail) અથવા ઘ (shell) જેવું દેખાય છે. તે UNESCO World Heritage Site છે. દર વર્ષ 1500 થી વધુ show ભજવાય!", "hi": "सिडनी ओपेरा हाउस ऑस्ट्रेलिया के सिडनी में है। यह समुद्र के पास विशाल सफेद पालों या सीपियों जैसा दिखता है। यह यूनेस्को विश्व धरोहर स्थल है। हर साल 1,500 से अधिक कार्यक्रम होते हैं!"}'::jsonb,
  '{"en": "Did you know? The roof of the Sydney Opera House is covered with over 1 million tiles that shimmer and change colour in the sunlight!", "gu": "શું તમે જાણો છો? સિડની ઓપેરા હાઉસની છત 10 લાખ ટાઈલ્સ વડે ઢંકાઈ છે, જે સૂર્ય-પ્રકાશ (sunlight) માં ઝળઝળ-ઝળ ચળકે!", "hi": "क्या आपको पता है? सिडनी ओपेरा हाउस की छत 10 लाख से अधिक टाइलों से ढकी है, जो धूप में चमकती और रंग बदलती हैं!"}'::jsonb,
  'memory', true, 7
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'christ_the_redeemer',
  (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Christ the Redeemer", "gu": "ક્રાઇસ્ટ ધ રિડીમર", "hi": "क्राइस्ट द रिडीमर"}'::jsonb,
  'assets/images/countries_culture/christ_the_redeemer.png',
  '{"en": "Christ the Redeemer! The giant statue with open arms on top of a mountain in Brazil!", "gu": "ક્રાઇસ્ટ ધ રિડીમર! બ્રાઝિલમાં ઘ (mountain) ટોચ ઉપર ખૂલ્લી ભૂ-ઘ (arms) સ-ઘ (statue)!", "hi": "क्राइस्ट द रिडीमर! ब्राजील में एक पहाड़ की चोटी पर खुली बाहों वाली विशाल मूर्ति!"}'::jsonb,
  '{"en": "Christ the Redeemer stands on Corcovado Mountain in Rio de Janeiro, Brazil. It is 30 meters tall with arms stretching 28 meters wide. It overlooks the entire city and is one of the New Seven Wonders of the World!", "gu": "ક્રાઇસ્ટ ધ રિડીમર બ્રાઝિલના રિઓ-ડ-ઝ-ઘ (Rio de Janeiro) માં ઘ (Corcovado Mountain) ઉપર ઊભો છે. 30 મીટર ઊંચો, 28 મીટર ઘ (arm) ફેલાવ. આખા શહેર ઉપર નઘ (overlooks) છે. નવા સ-ઘ (New Seven Wonders) માં!", "hi": "क्राइस्ट द रिडीमर ब्राजील के रियो डी जनेरियो में कोरकोवाडो पहाड़ पर खड़ा है। यह 30 मीटर ऊंचा है और इसकी भुजाएं 28 मीटर चौड़ी हैं। यह पूरे शहर को देखता है और दुनिया के नए सात अजूबों में से एक है!"}'::jsonb,
  '{"en": "Did you know? Christ the Redeemer is struck by lightning about 3-4 times every year, but it stays safe thanks to lightning rods installed inside!", "gu": "શું તમે જાણો છો? ક્રાઇસ્ટ ધ રિડીમ ર ઉપર દર વર્ષ 3-4 વખત વીજ-ઘ (lightning) ઝળ-ઘ (strike) પ-ઘ (pad) !, પ-ઘ (lightning rod) ના કારણ-ઘ (protection) !", "hi": "क्या आपको पता है? क्राइस्ट द रिडीमर पर हर साल 3-4 बार बिजली गिरती है, लेकिन अंदर लगे लाइटनिंग रॉड्स की वजह से यह सुरक्षित रहता है!"}'::jsonb,
  'memory', true, 8
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'leaning_tower_of_pisa',
  (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Leaning Tower of Pisa", "gu": "ઘ (Leaning Tower of Pisa)", "hi": "पीसा की मीनार"}'::jsonb,
  'assets/images/countries_culture/leaning_tower_of_pisa.png',
  '{"en": "Leaning Tower of Pisa! The famous tilted tower of Italy that never fell down!", "gu": "ઘ (Leaning Tower of Pisa)! ઇટ-ઘ (Italy) ની પ્ર-ઘ (famous) ઘ (tilted) ઘ (tower) — ઘ (never fell down)!", "hi": "पीसा की मीनार! इटली का प्रसिद्ध झुका हुआ टावर जो कभी गिरा नहीं!"}'::jsonb,
  '{"en": "The Leaning Tower of Pisa is in Pisa, Italy. It started leaning during construction because the soil on one side was too soft. It has been leaning for over 800 years! Scientists have worked hard to keep it from falling.", "gu": "ઘ (Leaning Tower of Pisa) ઇ-ઘ (Italy) ના ઘ (Pisa) માં છ. ઘ (construction) ઘ (during) ઘ (lean) ઘ (started) ઘ (because) ઘ-ઘ (soil) ઘ-ઘ (soft) !) 800 ઘ (years) ઘ (leaning)! ઘ (Scientists) ઘ (save) !", "hi": "पीसा की मीनार इटली के पीसा में है। निर्माण के दौरान एक तरफ की मिट्टी बहुत नरम होने के कारण यह झुकने लगी। यह 800 से अधिक वर्षों से झुकी हुई है! वैज्ञानिकों ने इसे गिरने से बचाने के लिए बहुत मेहनत की है।"}'::jsonb,
  '{"en": "Did you know? The Leaning Tower of Pisa leans about 4 degrees. Scientists have actually straightened it slightly since 1990 to make sure it won''t fall!", "gu": "ઘ (Did you know)? ઘ (Leaning Tower) ઘ (leans) 4 ° !, 1990 ઘ (since) ઘ (scientists) ઘ-ઘ (slightly) ઘ (straightened)!", "hi": "क्या आपको पता है? पीसा की मीनार लगभग 4 डिग्री झुकी है। 1990 के बाद से वैज्ञानिकों ने इसे थोड़ा सीधा किया है ताकि यह गिरे नहीं!"}'::jsonb,
  'memory', true, 9
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

-- ===================== TRADITIONAL HOMES =====================

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'igloo',
  (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Igloo", "gu": "ઇગ્લૂ", "hi": "इग्लू"}'::jsonb,
  'assets/images/countries_culture/igloo.png',
  '{"en": "Igloo! A cozy dome-shaped home built entirely from blocks of ice and snow!", "gu": "ઇગ્લૂ! બરફ-ઘ (ice) અને ઘ (snow) ઘ (blocks) ∫-ઘ (built) ઘ (dome-shaped) !", "hi": "इग्लू! बर्फ के खंडों से बना एक आरामदायक गुंबद के आकार का घर!"}'::jsonb,
  '{"en": "Igloos are traditional homes of the Inuit people who live in the Arctic. They are built from blocks of hard snow. Even though they are made of ice, the inside can be quite warm — up to 16°C warmer than outside!", "gu": "ઇગ્લૂ ઘ (Arctic) ઘ (Inuit people) ઘ (traditional homes). ઘ (hard snow blocks) ∫-ઘ (built). ઘ (inside) 16°C !", "hi": "इग्लू आर्कटिक में रहने वाले इनुइट लोगों के पारंपरिक घर हैं। वे कठोर बर्फ के खंडों से बने होते हैं। हालांकि वे बर्फ से बने हैं, अंदर काफी गर्म हो सकता है — बाहर से 16°C अधिक गर्म!"}'::jsonb,
  '{"en": "Did you know? The word ''igloo'' means ''house'' in the Inuit language! The entrance tunnel is built low so cold air stays outside.", "gu": "ઘ (Did you know)? ઘ (Inuit language) ∫-ઘ ''igloo'' = ''house''! !", "hi": "क्या आपको पता है? इनुइट भाषा में ''इग्लू'' का अर्थ है ''घर''! प्रवेश द्वार की सुरंग नीची बनाई जाती है ताकि ठंडी हवा बाहर रहे।"}'::jsonb,
  'memory', true, 10
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'tipi',
  (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Tipi", "gu": "ટિઘ (Tipi)", "hi": "टीपी"}'::jsonb,
  'assets/images/countries_culture/tipi.png',
  '{"en": "Tipi! A cone-shaped tent home used by Native American people on the plains!", "gu": "ટ-ઘ (Tipi)! !, !", "hi": "टीपी! अमेरिकी मैदानों पर मूल अमेरिकी लोगों द्वारा इस्तेमाल किया जाने वाला शंकु के आकार का तंबू घर!"}'::jsonb,
  '{"en": "The tipi (also spelled tepee) is a traditional home of many Native American tribes of the Great Plains. It is made of wooden poles covered with animal hides or canvas. It can be packed up and moved quickly — perfect for a nomadic lifestyle!", "gu": "ટ-ઘ (Tipi) / ઘ (tepee) !, !, !", "hi": "टीपी (तंबू) कई मूल अमेरिकी जनजातियों का पारंपरिक घर है। यह लकड़ी के खंभों से बना होता है जो जानवरों की खाल या कैनवास से ढके होते हैं। इसे जल्दी से बांधकर ले जाया जा सकता है!"}'::jsonb,
  '{"en": "Did you know? A tipi could be set up or taken down in under an hour, making it perfect for following herds of buffalo across the plains!", "gu": "ઘ (Did you know)? !", "hi": "क्या आपको पता है? एक टीपी को एक घंटे से भी कम समय में लगाया या हटाया जा सकता था, जो मैदानों में भैंसों के झुंड का पीछा करने के लिए बिल्कुल सही था!"}'::jsonb,
  'memory', true, 11
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'yurt',
  (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Yurt", "gu": "ઘ (Yurt)", "hi": "यर्ट"}'::jsonb,
  'assets/images/countries_culture/yurt.png',
  '{"en": "Yurt! A round portable home used by nomads across Central Asia!", "gu": "ઘ (Yurt)! !", "hi": "यर्ट! मध्य एशिया में खानाबदोश लोगों द्वारा उपयोग किया जाने वाला एक गोल पोर्टेबल घर!"}'::jsonb,
  '{"en": "A yurt is a circular portable home traditionally used by nomadic people in Mongolia, Kazakhstan, and Central Asia. It has a wooden frame covered with felt or canvas. Yurts are warm in winter and cool in summer!", "gu": "ઘ (Yurt) !, !, !", "hi": "यर्ट एक गोलाकार पोर्टेबल घर है जो मंगोलिया, कजाकिस्तान और मध्य एशिया के घुमंतू लोगों द्वारा परंपरागत रूप से उपयोग किया जाता है। इसमें लकड़ी का ढांचा होता है जो फेल्ट या कैनवास से ढका होता है। यर्ट सर्दियों में गर्म और गर्मियों में ठंडे होते हैं!"}'::jsonb,
  '{"en": "Did you know? In Mongolia, about 50% of the population still lives in yurts (called ''ger'' in Mongolian). Even the capital city has yurt neighborhoods!", "gu": "ઘ (Did you know)? !, !", "hi": "क्या आपको पता है? मंगोलिया में लगभग 50% आबादी अभी भी यर्ट (मंगोलियाई में ''गेर'' कहलाते हैं) में रहती है। यहां तक कि राजधानी शहर में भी यर्ट के मोहल्ले हैं!"}'::jsonb,
  'memory', true, 12
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'hut', (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Hut", "gu": "ઝૂંપડ", "hi": "झोपड़ी"}'::jsonb, 'assets/images/countries_culture/hut.png',
  '{"en": "Hut! A traditional thatched home found in villages across Africa and Asia!", "gu": "ઝૂંપડ! !", "hi": "झोपड़ी! अफ्रीका और एशिया के गांवों में पाया जाने वाला पारंपरिक घास-छत वाला घर!"}'::jsonb,
  '{"en": "A thatched hut is a simple home with walls made of mud or bamboo and a roof made of dried grass or leaves. These eco-friendly homes stay cool in summer and warm in winter naturally!", "gu": "ઝૂ-ઘ (Thatched hut) !, !", "hi": "एक छप्पर वाली झोपड़ी एक सरल घर है जिसकी दीवारें मिट्टी या बांस से और छत सूखी घास या पत्तियों से बनी होती है। ये पर्यावरण-अनुकूल घर प्राकृतिक रूप से गर्मियों में ठंडे और सर्दियों में गर्म रहते हैं!"}'::jsonb,
  '{"en": "Did you know? Thatched roofs are so good at insulating that they can last 40-50 years without being replaced!", "gu": "ઘ (Did you know)? !", "hi": "क्या आपको पता है? छप्पर की छतें इतनी अच्छी इन्सुलेटर होती हैं कि वे बिना बदले 40-50 साल तक चल सकती हैं!"}'::jsonb,
  'memory', true, 13
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'pagoda', (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Pagoda", "gu": "ઘ (Pagoda)", "hi": "पैगोडा"}'::jsonb, 'assets/images/countries_culture/pagoda.png',
  '{"en": "Pagoda! A tiered tower found in China, Japan, and other parts of Asia!", "gu": "ઘ (Pagoda)! !", "hi": "पैगोडा! चीन, जापान और एशिया के अन्य हिस्सों में पाया जाने वाला बहुमंजिला टावर!"}'::jsonb,
  '{"en": "A pagoda is a tiered tower with multiple curved roofs, found in Buddhist and Hindu temples across East and Southeast Asia. Each level of a pagoda has a symbolic meaning in the religion. They can have anywhere from 3 to 13 tiers!", "gu": "ઘ (Pagoda) !, !, 3 ∫ 13 !", "hi": "पैगोडा एक बहुमंजिला टावर है जिसमें कई घुमावदार छतें होती हैं, जो पूर्व और दक्षिण-पूर्व एशिया के बौद्ध और हिंदू मंदिरों में पाई जाती हैं। पैगोडा की प्रत्येक मंजिल का धर्म में एक प्रतीकात्मक अर्थ होता है।"}'::jsonb,
  '{"en": "Did you know? The Shwe Dagon Pagoda in Myanmar is covered in solid gold and stands 98 meters tall — taller than Big Ben!", "gu": "ઘ (Did you know)? !", "hi": "क्या आपको पता है? म्यांमार में श्वेडागोन पैगोडा ठोस सोने से ढका है और 98 मीटर ऊंचा है — बिग बेन से भी ऊंचा!"}'::jsonb,
  'memory', true, 14
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'cottage', (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Cottage", "gu": "ઘ (Cottage)", "hi": "कुटिया"}'::jsonb, 'assets/images/countries_culture/cottage.png',
  '{"en": "Cottage! A cozy little countryside home with a garden — a storybook house!", "gu": "ઘ (Cottage)! !", "hi": "कुटिया! बगीचे के साथ एक आरामदायक छोटा देहाती घर — एक कहानी की किताब वाला घर!"}'::jsonb,
  '{"en": "A cottage is a small, cozy home typically found in the countryside of England, Ireland, and Scotland. They often have thatched roofs, flower gardens, and chimneys. The word ''cottage'' comes from the Middle English word ''cot'' meaning a small shelter.", "gu": "ઘ (Cottage) !, !, ''cottage'' = ''cot'' = !", "hi": "एक कुटिया एक छोटा, आरामदायक घर होता है जो आमतौर पर इंग्लैंड, आयरलैंड और स्कॉटलैंड की ग्रामीण इलाकों में पाया जाता है। इनमें अक्सर घास की छत, फूलों के बगीचे और चिमनियां होती हैं।"}'::jsonb,
  '{"en": "Did you know? The world''s smallest inhabited cottage is in England and measures just 3.5 meters wide — barely enough room for one person!", "gu": "ઘ (Did you know)? !", "hi": "क्या आपको पता है? दुनिया की सबसे छोटी आबाद कुटिया इंग्लैंड में है और इसकी चौड़ाई केवल 3.5 मीटर है — एक व्यक्ति के लिए मुश्किल से जगह!"}'::jsonb,
  'memory', true, 15
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'houseboat', (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Houseboat", "gu": "હ-ઘ (Houseboat)", "hi": "हाउसबोट"}'::jsonb, 'assets/images/countries_culture/houseboat.png',
  '{"en": "Houseboat! A home that floats on water — like living on a boat!", "gu": "હ-ઘ (Houseboat)! !", "hi": "हाउसबोट! एक ऐसा घर जो पानी पर तैरता है — नाव पर रहने जैसा!"}'::jsonb,
  '{"en": "Houseboats are homes built on boats or floating platforms. They are popular in Dal Lake in Kashmir, India, and in Amsterdam, Netherlands. Some houseboats have gardens on the roof! People who live on them cook, sleep, and live just like in a regular house.", "gu": "ઘ (Houseboats) !, !, !", "hi": "हाउसबोट नावों या तैरते प्लेटफॉर्म पर बने घर हैं। वे कश्मीर, भारत में डल झील और नीदरलैंड के एम्स्टर्डम में लोकप्रिय हैं। कुछ हाउसबोट की छत पर बगीचे भी होते हैं!"}'::jsonb,
  '{"en": "Did you know? Amsterdam in the Netherlands has about 2,500 houseboats — it is one of the world''s largest houseboat cities!", "gu": "ઘ (Did you know)? !, 2500 !", "hi": "क्या आपको पता है? नीदरलैंड के एम्स्टर्डम में लगभग 2,500 हाउसबोट हैं — यह दुनिया के सबसे बड़े हाउसबोट शहरों में से एक है!"}'::jsonb,
  'memory', true, 16
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

-- ===================== TRADITIONAL CLOTHING =====================

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'kimono', (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Kimono", "gu": "ઘ (Kimono)", "hi": "किमोनो"}'::jsonb, 'assets/images/countries_culture/kimono.png',
  '{"en": "Kimono! The beautiful traditional T-shaped robe worn in Japan!", "gu": "ઘ (Kimono)! !", "hi": "किमोनो! जापान में पहना जाने वाला खूबसूरत पारंपरिक T-आकार का वस्त्र!"}'::jsonb,
  '{"en": "The kimono is Japan''s traditional garment. It is a T-shaped robe with wide sleeves, tied with a sash called an obi. Kimonos are often made of silk and decorated with beautiful patterns of flowers, birds, and nature scenes.", "gu": "ઘ (Kimono) !, !, !", "hi": "किमोनो जापान का पारंपरिक परिधान है। यह चौड़ी आस्तीन के साथ एक T-आकार का वस्त्र है, जिसे ओबी नामक एक पट्टी से बांधा जाता है। किमोनो अक्सर रेशम से बने होते हैं और फूलों, पक्षियों की सुंदर डिजाइनों से सजाए जाते हैं।"}'::jsonb,
  '{"en": "Did you know? A hand-crafted silk kimono can take months to make and cost as much as a car — some are even passed down through generations as family treasures!", "gu": "ઘ (Did you know)? !, !", "hi": "क्या आपको पता है? हाथ से बना रेशमी किमोनो बनाने में महीनों लग सकते हैं और एक कार जितना महंगा हो सकता है — कुछ तो परिवारों की विरासत के रूप में पीढ़ियों से पारित होते हैं!"}'::jsonb,
  'memory', true, 17
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'saree', (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Saree", "gu": "સ-ઘ (Saree)", "hi": "साड़ी"}'::jsonb, 'assets/images/countries_culture/saree.png',
  '{"en": "Saree! The elegant draped garment worn by women across India and South Asia!", "gu": "ઘ (Saree)! !", "hi": "साड़ी! भारत और दक्षिण एशिया में महिलाओं द्वारा पहना जाने वाला सुंदर लिपटा हुआ परिधान!"}'::jsonb,
  '{"en": "The saree is a long piece of fabric — usually 5 to 9 meters — that is draped elegantly around the body. It is one of the oldest forms of clothing in the world, worn for over 5,000 years! Sarees come in thousands of styles, fabrics, and colors.", "gu": "ઘ (Saree) 5-9 !, 5000 !, !", "hi": "साड़ी कपड़े का एक लंबा टुकड़ा है — आमतौर पर 5 से 9 मीटर — जिसे शरीर के चारों ओर सुंदरता से लपेटा जाता है। यह दुनिया के सबसे पुराने कपड़ों में से एक है, जो 5,000 से अधिक वर्षों से पहना जा रहा है!"}'::jsonb,
  '{"en": "Did you know? There are over 80 different ways to drape a saree across India — each region has its own unique style!", "gu": "ઘ (Did you know)? 80 !, !", "hi": "क्या आपको पता है? भारत में साड़ी लपेटने के 80 से अधिक विभिन्न तरीके हैं — हर क्षेत्र का अपना अनूठा तरीका होता है!"}'::jsonb,
  'memory', true, 18
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'kilt', (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Kilt", "gu": "ઘ (Kilt)", "hi": "किल्ट"}'::jsonb, 'assets/images/countries_culture/kilt.png',
  '{"en": "Kilt! The traditional tartan skirt worn by men in Scotland!", "gu": "ઘ (Kilt)! !", "hi": "किल्ट! स्कॉटलैंड में पुरुषों द्वारा पहना जाने वाला पारंपरिक टार्टन स्कर्ट!"}'::jsonb,
  '{"en": "A kilt is a knee-length skirt with pleats at the back, traditionally worn by Scottish men. Each Scottish clan (family group) has its own unique tartan (plaid pattern). Kilts are often worn with sporrans (small pouches) and tall socks!", "gu": "ઘ (Kilt) !, !, !", "hi": "एक किल्ट एक घुटने तक की लंबाई की स्कर्ट है जिसमें पीछे की तरफ प्लीट्स हैं, जो परंपरागत रूप से स्कॉटिश पुरुषों द्वारा पहनी जाती है। प्रत्येक स्कॉटिश कबीले (परिवार समूह) का अपना अनूठा टार्टन (चेकदार पैटर्न) होता है।"}'::jsonb,
  '{"en": "Did you know? A full kilt uses about 7-8 meters of fabric! Modern kilts can weigh up to 3 kg — that''s like carrying 3 bags of sugar!", "gu": "ઘ (Did you know)? 7-8 !, 3 kg !", "hi": "क्या आपको पता है? एक पूरे किल्ट में लगभग 7-8 मीटर कपड़े का उपयोग होता है! आधुनिक किल्ट का वजन 3 किग्रा तक हो सकता है — जैसे 3 चीनी के थैले उठाना!"}'::jsonb,
  'memory', true, 19
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'hanbok', (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Hanbok", "gu": "ઘ (Hanbok)", "hi": "हनबोक"}'::jsonb, 'assets/images/countries_culture/hanbok.png',
  '{"en": "Hanbok! The graceful, colorful traditional costume of Korea!", "gu": "ઘ (Hanbok)! !", "hi": "हनबोक! कोरिया का सुंदर, रंगीन पारंपरिक पोशाक!"}'::jsonb,
  '{"en": "Hanbok is the traditional Korean dress with vibrant colors and simple lines. Women wear a short jacket (jeogori) with a long, wrap skirt (chima). Men wear a jacket with baggy trousers. Hanbok has been worn for over 1,600 years!", "gu": "ઘ (Hanbok) !, 1600 !", "hi": "हनबोक पारंपरिक कोरियाई पोशाक है जिसमें जीवंत रंग और सरल रेखाएं हैं। महिलाएं एक छोटी जैकेट (जेओगोरी) के साथ लंबी, लपेट वाली स्कर्ट (चिमा) पहनती हैं। हनबोक 1,600 से अधिक वर्षों से पहना जा रहा है!"}'::jsonb,
  '{"en": "Did you know? Hanbok is still worn during Korean holidays and celebrations like Seollal (Lunar New Year) and Chuseok (Harvest Festival)!", "gu": "ઘ (Did you know)? !", "hi": "क्या आपको पता है? हनबोक अभी भी कोरियाई छुट्टियों और उत्सवों जैसे सेओलाल (चंद्र नव वर्ष) और चुसोक (फसल उत्सव) के दौरान पहना जाता है!"}'::jsonb,
  'memory', true, 20
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'thobe', (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Thobe", "gu": "ઘ (Thobe)", "hi": "थोब"}'::jsonb, 'assets/images/countries_culture/thobe.png',
  '{"en": "Thobe! The long flowing white robe worn by men in Arab countries!", "gu": "ઘ (Thobe)! !", "hi": "थोब! अरब देशों में पुरुषों द्वारा पहना जाने वाला लंबा बहता हुआ सफेद वस्त्र!"}'::jsonb,
  '{"en": "The thobe (also thawb) is a long ankle-length garment traditionally worn by men in Arab countries like Saudi Arabia, UAE, and Qatar. It is usually white to reflect the sun and keep cool. It is comfortable in hot desert climates!", "gu": "ઘ (Thobe) !, !", "hi": "थोब एक लंबा टखने तक का परिधान है जो परंपरागत रूप से सऊदी अरब, यूएई और कतर जैसे अरब देशों में पुरुषों द्वारा पहना जाता है। यह आमतौर पर सूरज को परावर्तित करने और ठंडा रहने के लिए सफेद होता है।"}'::jsonb,
  '{"en": "Did you know? The white thobe reflects sunlight and keeps the wearer cool even in temperatures over 40°C (104°F) — it''s like wearing a personal air conditioner!", "gu": "ઘ (Did you know)? 40°C !", "hi": "क्या आपको पता है? सफेद थोब सूर्य के प्रकाश को परावर्तित करता है और 40°C (104°F) से अधिक तापमान में भी पहनने वाले को ठंडा रखता है — यह एक व्यक्तिगत एयर कंडीशनर पहनने जैसा है!"}'::jsonb,
  'memory', true, 21
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'sombrero', (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Sombrero", "gu": "ઘ (Sombrero)", "hi": "सोम्ब्रेरो"}'::jsonb, 'assets/images/countries_culture/sombrero.png',
  '{"en": "Sombrero! The wide-brimmed colourful hat from Mexico!", "gu": "ઘ (Sombrero)! !", "hi": "सोम्ब्रेरो! मेक्सिको की चौड़ी किनारी वाली रंगीन टोपी!"}'::jsonb,
  '{"en": "The sombrero is a type of wide-brimmed hat from Mexico. The word ''sombrero'' comes from Spanish, meaning ''shade.'' The wide brim protects the face and shoulders from the hot sun. They are often decorated with colorful embroidery!", "gu": "ઘ (Sombrero) = !, !", "hi": "सोम्ब्रेरो मेक्सिको की एक प्रकार की चौड़ी किनारी वाली टोपी है। ''सोम्ब्रेरो'' शब्द स्पेनिश से आया है, जिसका अर्थ है ''छाया।'' चौड़ी किनारी चेहरे और कंधों को तेज धूप से बचाती है।"}'::jsonb,
  '{"en": "Did you know? The world''s largest sombrero was made in Mexico and measured over 3 meters (10 feet) wide — big enough to stand under!", "gu": "ઘ (Did you know)? 3 !, !", "hi": "क्या आपको पता है? दुनिया का सबसे बड़ा सोम्ब्रेरो मेक्सिको में बनाया गया था और 3 मीटर (10 फीट) से अधिक चौड़ा था — इसके नीचे खड़े होने के लिए काफी बड़ा!"}'::jsonb,
  'memory', true, 22
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'hanfu', (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Hanfu", "gu": "ઘ (Hanfu)", "hi": "हान्फू"}'::jsonb, 'assets/images/countries_culture/hanfu.png',
  '{"en": "Hanfu! The ancient flowing robes of traditional Chinese clothing!", "gu": "ઘ (Hanfu)! !", "hi": "हान्फू! पारंपरिक चीनी कपड़ों के प्राचीन बहते हुए वस्त्र!"}'::jsonb,
  '{"en": "Hanfu is the traditional clothing of the Han Chinese people, worn for over 3,000 years. It features flowing robes with wide sleeves and cross-collar designs. Today, many young Chinese people are reviving Hanfu as a way to celebrate their heritage!", "gu": "ઘ (Hanfu) 3000 !, !", "hi": "हान्फू हान चीनी लोगों का पारंपरिक कपड़ा है, जो 3,000 से अधिक वर्षों से पहना जा रहा है। इसमें चौड़ी आस्तीन और क्रॉस-कॉलर डिजाइन के साथ बहते हुए वस्त्र शामिल हैं।"}'::jsonb,
  '{"en": "Did you know? Hanfu is experiencing a massive revival in China — millions of young people now wear it for photos, cultural events, and everyday fashion!", "gu": "ઘ (Did you know)? !", "hi": "क्या आपको पता है? चीन में हान्फू का जबरदस्त पुनरुद्धार हो रहा है — लाखों युवा अब इसे फोटो, सांस्कृतिक कार्यक्रमों और रोजमर्रा के फैशन के लिए पहनते हैं!"}'::jsonb,
  'memory', true, 23
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

-- ===================== TRADITIONAL FOOD =====================

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'pizza', (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Pizza", "gu": "ઘ (Pizza)", "hi": "पिज्जा"}'::jsonb, 'assets/images/countries_culture/pizza.png',
  '{"en": "Pizza! Italy''s most famous gift to the world — cheesy, saucy, and delicious!", "gu": "ઘ (Pizza)! !", "hi": "पिज्जा! इटली का दुनिया को सबसे मशहूर तोहफा — पनीर, सॉस और स्वादिष्ट!"}'::jsonb,
  '{"en": "Pizza comes from Naples, Italy. A traditional Neapolitan pizza has a thin crust, tomato sauce, mozzarella cheese, and fresh basil leaves. Today it is one of the most popular foods in the world, with thousands of topping variations!", "gu": "ઘ (Pizza) !, !", "hi": "पिज्जा इटली के नेपल्स से आता है। एक पारंपरिक नेपोलिटन पिज्जा में पतली परत, टमाटर सॉस, मोज़ारेला चीज और ताजी तुलसी की पत्तियां होती हैं।"}'::jsonb,
  '{"en": "Did you know? About 5 billion pizzas are consumed worldwide every year — that''s about 13 million pizzas every single day!", "gu": "ઘ (Did you know)? !", "hi": "क्या आपको पता है? दुनिया भर में हर साल लगभग 5 अरब पिज्जा खाए जाते हैं — यानी हर एक दिन लगभग 1.3 करोड़ पिज्जा!"}'::jsonb,
  'memory', true, 24
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'sushi', (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Sushi", "gu": "ઘ (Sushi)", "hi": "सुशी"}'::jsonb, 'assets/images/countries_culture/sushi.png',
  '{"en": "Sushi! Japan''s famous bite-sized rolls of rice and fresh fish!", "gu": "ઘ (Sushi)! !", "hi": "सुशी! जापान के प्रसिद्ध चावल और ताज़ी मछली के छोटे-छोटे रोल!"}'::jsonb,
  '{"en": "Sushi is a traditional Japanese food made with vinegared rice and various toppings like raw fish, vegetables, and seaweed. It requires great skill to make — sushi chefs train for years to perfect their craft!", "gu": "ઘ (Sushi) !, !", "hi": "सुशी सिरके वाले चावल और कच्ची मछली, सब्जियों और समुद्री शैवाल जैसे विभिन्न टॉपिंग के साथ एक पारंपरिक जापानी भोजन है।"}'::jsonb,
  '{"en": "Did you know? The most expensive sushi in the world costs over $600 per piece — it uses rare fish, edible gold, and luxury truffles!", "gu": "ઘ (Did you know)? $600 !, !", "hi": "क्या आपको पता है? दुनिया की सबसे महंगी सुशी प्रति टुकड़ा $600 से अधिक में मिलती है — इसमें दुर्लभ मछली, खाने योग्य सोना और लक्जरी ट्रफल का उपयोग होता है!"}'::jsonb,
  'memory', true, 25
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'tacos', (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Tacos", "gu": "ઘ (Tacos)", "hi": "टैकोस"}'::jsonb, 'assets/images/countries_culture/tacos.png',
  '{"en": "Tacos! Mexico''s delicious folded tortillas filled with yummy toppings!", "gu": "ઘ (Tacos)! !", "hi": "टैकोस! मेक्सिको के स्वादिष्ट मुड़े हुए टॉर्टिला स्वादिष्ट टॉपिंग से भरे!"}'::jsonb,
  '{"en": "Tacos are a traditional Mexican dish consisting of a folded or rolled tortilla filled with various ingredients like meat, beans, cheese, salsa, guacamole, and fresh vegetables. There are hundreds of regional varieties across Mexico!", "gu": "ઘ (Tacos) !, !", "hi": "टैकोस एक पारंपरिक मैक्सिकन व्यंजन है जिसमें मांस, बीन्स, पनीर, साल्सा, गुआकामोल और ताज़ी सब्जियों जैसी विभिन्न सामग्रियों से भरा एक मुड़ा हुआ टॉर्टिला होता है।"}'::jsonb,
  '{"en": "Did you know? October 4th is ''National Taco Day'' in the USA! Americans eat over 4.5 billion tacos every year!", "gu": "ઘ (Did you know)? 4 !, 4.5 !", "hi": "क्या आपको पता है? 4 अक्टूबर अमेरिका में ''राष्ट्रीय टैको दिवस'' है! अमेरिकी हर साल 4.5 अरब से अधिक टैकोस खाते हैं!"}'::jsonb,
  'memory', true, 26
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'paella', (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Paella", "gu": "ઘ (Paella)", "hi": "पेएया"}'::jsonb, 'assets/images/countries_culture/paella.png',
  '{"en": "Paella! Spain''s colorful rice dish cooked in a giant pan!", "gu": "ઘ (Paella)! !", "hi": "पेएया! स्पेन का रंगीन चावल का व्यंजन एक विशाल पैन में पकाया गया!"}'::jsonb,
  '{"en": "Paella is a traditional Spanish rice dish originating from Valencia. It is cooked in a wide, shallow pan and traditionally contains rice, saffron, vegetables, and proteins like chicken, rabbit, or seafood. The golden color comes from saffron!", "gu": "ઘ (Paella) !, !", "hi": "पेएया वैलेंसिया से उत्पन्न एक पारंपरिक स्पेनिश चावल का व्यंजन है। इसे एक चौड़े, उथले पैन में पकाया जाता है और इसमें पारंपरिक रूप से चावल, केसर, सब्जियां होती हैं।"}'::jsonb,
  '{"en": "Did you know? The world''s largest paella fed over 100,000 people! It was made in Valencia, Spain and used 6,000 kg of rice and 12,000 kg of meat!", "gu": "ઘ (Did you know)? 100,000 !, !", "hi": "क्या आपको पता है? दुनिया की सबसे बड़ी पेएया ने 1,00,000 से अधिक लोगों को खिलाया! यह स्पेन के वैलेंसिया में बनाई गई थी और इसमें 6,000 किग्रा चावल और 12,000 किग्रा मांस का उपयोग हुआ था!"}'::jsonb,
  'memory', true, 27
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'croissant', (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Croissant", "gu": "ઘ (Croissant)", "hi": "क्रोइसां"}'::jsonb, 'assets/images/countries_culture/croissant.png',
  '{"en": "Croissant! France''s buttery, flaky, crescent-shaped pastry — ooh la la!", "gu": "ઘ (Croissant)! !", "hi": "क्रोइसां! फ्रांस की मक्खनदार, परतदार, अर्धचंद्राकार पेस्ट्री — ओह ला ला!"}'::jsonb,
  '{"en": "The croissant is a buttery, flaky pastry from France. Despite being associated with France, it was actually invented in Austria! It was brought to Paris in the 1830s. The crescent shape is inspired by the Austrian flag''s crescent symbol.", "gu": "ઘ (Croissant) !, !", "hi": "क्रोइसां फ्रांस की एक मक्खनदार, परतदार पेस्ट्री है। फ्रांस से जुड़े होने के बावजूद, यह वास्तव में ऑस्ट्रिया में आविष्कार हुआ था! इसे 1830 के दशक में पेरिस लाया गया था।"}'::jsonb,
  '{"en": "Did you know? A proper French croissant is made with 27 layers of buttery dough! It takes a skilled baker about 3 days to make them from scratch.", "gu": "ઘ (Did you know)? 27 !, 3 !", "hi": "क्या आपको पता है? एक उचित फ्रेंच क्रोइसां मक्खनदार आटे की 27 परतों से बनाया जाता है! एक कुशल बेकर को इसे शुरू से बनाने में लगभग 3 दिन लगते हैं।"}'::jsonb,
  'memory', true, 28
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'pretzel', (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Pretzel", "gu": "ઘ (Pretzel)", "hi": "प्रेट्ज़ेल"}'::jsonb, 'assets/images/countries_culture/pretzel.png',
  '{"en": "Pretzel! Germany''s famous twisted bread snack — salty and crunchy!", "gu": "ઘ (Pretzel)! !", "hi": "प्रेट्ज़ेल! जर्मनी का प्रसिद्ध मुड़ा हुआ ब्रेड स्नैक — नमकीन और कुरकुरा!"}'::jsonb,
  '{"en": "The pretzel is a traditional German baked bread with a distinctive twisted knot shape. It is brushed with lye (a salty solution) before baking, which gives it the shiny brown crust. Pretzels have been a German tradition for over 600 years!", "gu": "ઘ (Pretzel) 600 !, !", "hi": "प्रेट्ज़ेल एक पारंपरिक जर्मन बेक्ड ब्रेड है जिसमें एक विशिष्ट मुड़ी हुई गांठ का आकार है। इसे बेकिंग से पहले लाई (एक नमकीन घोल) से ब्रश किया जाता है, जो इसे चमकदार भूरी परत देता है।"}'::jsonb,
  '{"en": "Did you know? The twisted shape of a pretzel was originally designed to represent arms crossed in prayer! Medieval monks created this shape in the 7th century.", "gu": "ઘ (Did you know)? !", "hi": "क्या आपको पता है? प्रेट्ज़ेल का मुड़ा हुआ आकार मूल रूप से प्रार्थना में भुजाओं को क्रॉस करके बनाने के लिए डिज़ाइन किया गया था! मध्यकालीन भिक्षुओं ने 7वीं शताब्दी में यह आकार बनाया था।"}'::jsonb,
  'memory', true, 29
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'dumplings', (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Dumplings", "gu": "ઘ (Dumplings)", "hi": "डम्पलिंग्स"}'::jsonb, 'assets/images/countries_culture/dumplings.png',
  '{"en": "Dumplings! China''s little parcels of dough filled with delicious stuffing!", "gu": "ઘ (Dumplings)! !", "hi": "डम्पलिंग्स! चीन के आटे के छोटे पार्सल स्वादिष्ट भराई से भरे!"}'::jsonb,
  '{"en": "Dumplings are small dough pockets filled with meat, vegetables, or seafood — popular across China, Japan (gyoza), Korea (mandu), and many other Asian countries. In China, dumplings are eaten during Chinese New Year to bring good luck!", "gu": "ઘ (Dumplings) !, !", "hi": "डम्पलिंग्स आटे की छोटी जेबें हैं जो मांस, सब्जियों या समुद्री भोजन से भरी होती हैं — चीन, जापान (ग्योज़ा), कोरिया (मंडू) और कई अन्य एशियाई देशों में लोकप्रिय हैं।"}'::jsonb,
  '{"en": "Did you know? During Chinese New Year, families hide a coin inside one dumpling — whoever finds it is said to have good luck all year!", "gu": "ઘ (Did you know)? !, !", "hi": "क्या आपको पता है? चीनी नव वर्ष के दौरान, परिवार एक डम्पलिंग के अंदर एक सिक्का छुपाते हैं — जो इसे ढूंढता है उसे साल भर भाग्यशाली कहा जाता है!"}'::jsonb,
  'memory', true, 30
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'biryani', (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Biryani", "gu": "ઘ (Biryani)", "hi": "बिरयानी"}'::jsonb, 'assets/images/countries_culture/biryani.png',
  '{"en": "Biryani! India''s fragrant spiced rice dish full of rich flavors!", "gu": "ઘ (Biryani)! !", "hi": "बिरयानी! भारत का सुगंधित मसालेदार चावल का व्यंजन भरपूर स्वाद से भरपूर!"}'::jsonb,
  '{"en": "Biryani is a fragrant mixed rice dish from South Asia made with basmati rice, spices, and usually meat or vegetables. It is cooked using a special slow-cooking method called ''dum'' where everything is sealed and steamed together.", "gu": "ઘ (Biryani) !, ''dum'' !", "hi": "बिरयानी दक्षिण एशिया का एक सुगंधित मिश्रित चावल का व्यंजन है जो बासमती चावल, मसालों और आमतौर पर मांस या सब्जियों से बना है। इसे ''दम'' नामक एक विशेष धीमी-पकाने की विधि का उपयोग करके पकाया जाता है।"}'::jsonb,
  '{"en": "Did you know? There are over 26 varieties of biryani in India alone — each city has its own secret recipe! Hyderabadi biryani is the most famous.", "gu": "ઘ (Did you know)? 26 !, !, !", "hi": "क्या आपको पता है? अकेले भारत में बिरयानी की 26 से अधिक किस्में हैं — हर शहर का अपना गुप्त नुस्खा है! हैदराबादी बिरयानी सबसे प्रसिद्ध है।"}'::jsonb,
  'memory', true, 31
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

-- ===================== INSTRUMENTS =====================

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'tabla', (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Tabla", "gu": "ઘ (Tabla)", "hi": "तबला"}'::jsonb, 'assets/images/countries_culture/tabla.png',
  '{"en": "Tabla! India''s beautiful pair of hand drums that make magical rhythms!", "gu": "ઘ (Tabla)! !", "hi": "तबला! भारत की सुंदर जोड़ी हाथ के ढोल जो जादुई लय बनाते हैं!"}'::jsonb,
  '{"en": "The tabla is a pair of hand drums used in classical Indian music. The smaller drum (''dayan'') is played with the right hand and the larger drum (''bayan'') with the left. Tabla players can create hundreds of different rhythms and sounds!", "gu": "ઘ (Tabla) !, ''dayan'' (right hand), ''bayan'' (left hand) !, !", "hi": "तबला हाथ के ढोलों की एक जोड़ी है जिसका उपयोग शास्त्रीय भारतीय संगीत में किया जाता है। छोटा ढोल (''दायान'') दाहिने हाथ से और बड़ा ढोल (''बायां'') बाएं हाथ से बजाया जाता है।"}'::jsonb,
  '{"en": "Did you know? The tabla can produce over 16 distinct sounds by striking different parts of the drum — it is considered one of the most complex percussion instruments in the world!", "gu": "ઘ (Did you know)? 16 !, !", "hi": "क्या आपको पता है? तबला ढोल के विभिन्न हिस्सों को मारकर 16 से अधिक अलग-अलग आवाजें पैदा कर सकता है — इसे दुनिया के सबसे जटिल ताल वाद्ययंत्रों में से एक माना जाता है!"}'::jsonb,
  'memory', true, 32
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'sitar', (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Sitar", "gu": "ઘ (Sitar)", "hi": "सितार"}'::jsonb, 'assets/images/countries_culture/sitar.png',
  '{"en": "Sitar! India''s beautiful long-necked string instrument with a magical sound!", "gu": "ઘ (Sitar)! !", "hi": "सितार! भारत का सुंदर लंबी गर्दन वाला तार वाद्ययंत्र जादुई आवाज के साथ!"}'::jsonb,
  '{"en": "The sitar is a plucked string instrument used in Hindustani classical music from northern India. It has 18-21 strings and can produce beautiful, resonant notes. The great maestro Ravi Shankar introduced sitar music to the world stage!", "gu": "ઘ (Sitar) 18-21 !, !, !", "hi": "सितार एक तोड़ा हुआ तार वाद्ययंत्र है जिसका उपयोग उत्तरी भारत के हिंदुस्तानी शास्त्रीय संगीत में किया जाता है। इसमें 18-21 तार हैं और सुंदर, गूंजती हुई धुनें उत्पन्न कर सकता है।"}'::jsonb,
  '{"en": "Did you know? The Beatles'' George Harrison learned to play the sitar and used it in their songs, making Indian classical music famous all around the world in the 1960s!", "gu": "ઘ (Did you know)? !, !", "hi": "क्या आपको पता है? बीटल्स के जॉर्ज हैरिसन ने सितार बजाना सीखा और इसे उनके गानों में इस्तेमाल किया, जिससे 1960 के दशक में भारतीय शास्त्रीय संगीत दुनिया भर में प्रसिद्ध हो गया!"}'::jsonb,
  'memory', true, 33
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'bagpipes', (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Bagpipes", "gu": "ઘ (Bagpipes)", "hi": "बैगपाइप"}'::jsonb, 'assets/images/countries_culture/bagpipes.png',
  '{"en": "Bagpipes! Scotland''s iconic wind instrument that fills the air with powerful music!", "gu": "ઘ (Bagpipes)! !", "hi": "बैगपाइप! स्कॉटलैंड का प्रतिष्ठित वायु वाद्ययंत्र जो हवा को शक्तिशाली संगीत से भर देता है!"}'::jsonb,
  '{"en": "Bagpipes are a wind instrument with an air bag and multiple pipes. The player blows air into the bag while squeezing it to force air through the pipes, creating a continuous sound. They are most associated with Scotland but exist in many cultures!", "gu": "ઘ (Bagpipes) !, !", "hi": "बैगपाइप एक वायु वाद्ययंत्र है जिसमें एक एयर बैग और कई पाइप हैं। खिलाड़ी बैग में हवा फूंकता है जबकि पाइपों में हवा मजबूर करने के लिए इसे दबाता है, जिससे एक निरंतर आवाज आती है।"}'::jsonb,
  '{"en": "Did you know? Bagpipes can be heard from up to 10 miles away — that''s why they were used in battle to signal and inspire troops from a great distance!", "gu": "ઘ (Did you know)? 10 !, !", "hi": "क्या आपको पता है? बैगपाइप 10 मील दूर तक सुने जा सकते हैं — इसीलिए युद्ध में सैनिकों को दूर से संकेत देने और प्रेरित करने के लिए उनका उपयोग किया जाता था!"}'::jsonb,
  'memory', true, 34
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'didgeridoo', (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Didgeridoo", "gu": "ઘ (Didgeridoo)", "hi": "डिडगेरिडू"}'::jsonb, 'assets/images/countries_culture/didgeridoo.png',
  '{"en": "Didgeridoo! Australia''s ancient Aboriginal wind instrument with a deep, buzzing sound!", "gu": "ઘ (Didgeridoo)! !", "hi": "डिडगेरिडू! ऑस्ट्रेलिया का प्राचीन आदिवासी वायु वाद्ययंत्र गहरी, भनभनाती आवाज के साथ!"}'::jsonb,
  '{"en": "The didgeridoo is a wind instrument of the Aboriginal Australians, made from a hollowed-out eucalyptus branch. It creates a deep, droning sound. It is one of the oldest musical instruments in the world, played for over 1,500 years!", "gu": "ઘ (Didgeridoo) !, 1500 !", "hi": "डिडगेरिडू ऑस्ट्रेलिया के आदिवासियों का एक वायु वाद्ययंत्र है, जो खोखले नीलगिरी की शाखा से बना है। यह एक गहरी, भनभनाने वाली आवाज बनाता है। यह दुनिया के सबसे पुराने संगीत वाद्ययंत्रों में से एक है, जो 1,500 से अधिक वर्षों से बजाया जा रहा है!"}'::jsonb,
  '{"en": "Did you know? Playing the didgeridoo requires a special breathing technique called ''circular breathing'' — you breathe in through your nose while blowing out through your mouth at the same time!", "gu": "ઘ (Did you know)? ''circular breathing'' !, !", "hi": "क्या आपको पता है? डिडगेरिडू बजाने के लिए ''सर्कुलर ब्रीदिंग'' नामक एक विशेष श्वास तकनीक की आवश्यकता होती है — आप एक साथ नाक से सांस लेते हैं और मुंह से बाहर फूंकते हैं!"}'::jsonb,
  'memory', true, 35
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

-- ===================== CULTURAL OBJECTS =====================

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'diya', (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Diya", "gu": "ઘ (Diya)", "hi": "दीया"}'::jsonb, 'assets/images/countries_culture/diya.png',
  '{"en": "Diya! The beautiful clay oil lamp lit during Diwali — the festival of lights!", "gu": "ઘ (Diya)! !", "hi": "दीया! दिवाली — प्रकाश के त्योहार के दौरान जलाया जाने वाला सुंदर मिट्टी का तेल का दीपक!"}'::jsonb,
  '{"en": "A diya is a small oil lamp made from clay, filled with oil and a cotton wick. Diyas are lit during Diwali, the Hindu festival of lights. Millions of diyas are lit across India and around the world, filling the night with golden light!", "gu": "ઘ (Diya) !, !, !", "hi": "दीया मिट्टी का एक छोटा तेल का दीपक है, जिसमें तेल और एक कपास की बाती होती है। दिवाली, हिंदू प्रकाश उत्सव के दौरान दीये जलाए जाते हैं।"}'::jsonb,
  '{"en": "Did you know? During Diwali, over 70 million diyas are lit in Ayodhya, India — making it one of the most spectacular light displays in the world!", "gu": "ઘ (Did you know)? 7 !, !", "hi": "क्या आपको पता है? दिवाली के दौरान, भारत के अयोध्या में 7 करोड़ से अधिक दीये जलाए जाते हैं — इसे दुनिया के सबसे शानदार प्रकाश प्रदर्शनों में से एक बनाता है!"}'::jsonb,
  'memory', true, 36
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'chinese_lantern', (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Chinese Lantern", "gu": "ઘ (Chinese Lantern)", "hi": "चीनी लालटेन"}'::jsonb, 'assets/images/countries_culture/chinese_lantern.png',
  '{"en": "Chinese Lantern! The glowing red lanterns of China — symbols of luck and celebration!", "gu": "ઘ (Chinese Lantern)! !", "hi": "चीनी लालटेन! चीन की चमकती लाल लालटेनें — भाग्य और उत्सव के प्रतीक!"}'::jsonb,
  '{"en": "Chinese lanterns are traditional red paper lanterns hung during festivals. They are a symbol of good luck, happiness, and prosperity. During the Chinese Lantern Festival (15th day of Chinese New Year), thousands of lanterns light up the sky!", "gu": "ઘ (Chinese lanterns) !, !, !", "hi": "चीनी लालटेनें पारंपरिक लाल कागज की लालटेनें हैं जो त्योहारों के दौरान लटकाई जाती हैं। वे सौभाग्य, खुशी और समृद्धि का प्रतीक हैं।"}'::jsonb,
  '{"en": "Did you know? Chinese lanterns were invented over 2,000 years ago — they were originally used to worship ancestors and scare away evil spirits!", "gu": "ઘ (Did you know)? 2000 !, !", "hi": "क्या आपको पता है? चीनी लालटेनों का आविष्कार 2,000 से अधिक वर्ष पहले हुआ था — मूल रूप से इन्हें पूर्वजों की पूजा करने और बुरी आत्माओं को डराने के लिए इस्तेमाल किया जाता था!"}'::jsonb,
  'memory', true, 37
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'dreamcatcher', (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Dreamcatcher", "gu": "ઘ (Dreamcatcher)", "hi": "ड्रीमकैचर"}'::jsonb, 'assets/images/countries_culture/dreamcatcher.png',
  '{"en": "Dreamcatcher! The beautiful woven hoop that catches bad dreams and lets good ones through!", "gu": "ઘ (Dreamcatcher)! !", "hi": "ड्रीमकैचर! सुंदर बुना हुआ घेरा जो बुरे सपनों को पकड़ता है और अच्छे सपनों को जाने देता है!"}'::jsonb,
  '{"en": "The dreamcatcher is a handmade willow hoop with a woven net, decorated with feathers and beads. It is a sacred object of the Ojibwe (Chippewa) Native American people. According to tradition, it filters out bad dreams at night!", "gu": "ઘ (Dreamcatcher) !, !, !", "hi": "ड्रीमकैचर एक हस्तनिर्मित विलो हूप है जिसमें एक बुनी हुई जाली है, पंखों और मोतियों से सजाई गई है। यह ओजिब्वे (चिप्पेवा) मूल अमेरिकी लोगों की एक पवित्र वस्तु है।"}'::jsonb,
  '{"en": "Did you know? In Ojibwe legend, the dreamcatcher was made by ''Spider Woman'' who created the first one to protect children from bad dreams and evil spirits!", "gu": "ઘ (Did you know)? ''Spider Woman'' !, !", "hi": "क्या आपको पता है? ओजिब्वे किंवदंती में, ड्रीमकैचर ''स्पाइडर वुमन'' ने बनाया था जिसने बच्चों को बुरे सपनों और बुरी आत्माओं से बचाने के लिए पहला बनाया था!"}'::jsonb,
  'memory', true, 38
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'matryoshka_doll', (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Matryoshka Doll", "gu": "ઘ (Matryoshka Doll)", "hi": "मात्र्योशका डॉल"}'::jsonb, 'assets/images/countries_culture/matryoshka_doll.png',
  '{"en": "Matryoshka! Russia''s famous nesting dolls — one doll hides inside another!", "gu": "ઘ (Matryoshka)! !", "hi": "मात्र्योशका! रूस की प्रसिद्ध नेस्टिंग डॉल — एक गुड़िया दूसरे के अंदर छुपी है!"}'::jsonb,
  '{"en": "The matryoshka (Russian nesting doll) is a set of wooden dolls of decreasing size placed one inside another. They are painted with colorful folk art designs. The name comes from the Russian name ''Matryona.'' A typical set has 5-10 dolls!", "gu": "ઘ (Matryoshka) !, 5-10 !", "hi": "मात्र्योशका (रूसी नेस्टिंग डॉल) एक घटते आकार की लकड़ी की गुड़ियों का एक सेट है जो एक दूसरे के अंदर रखी जाती हैं। वे रंगीन लोक कला डिजाइन से चित्रित हैं।"}'::jsonb,
  '{"en": "Did you know? The world record for the most pieces in a matryoshka set is 51 dolls — each one fitting perfectly inside the next, from the size of a finger to the size of a fist!", "gu": "ઘ (Did you know)? 51 !, !", "hi": "क्या आपको पता है? मात्र्योशका सेट में सबसे अधिक टुकड़ों का विश्व रिकॉर्ड 51 गुड़िया है — हर एक अगले के अंदर बिल्कुल फिट है, एक उंगली के आकार से लेकर मुट्ठी के आकार तक!"}'::jsonb,
  'memory', true, 39
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'totem_pole', (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Totem Pole", "gu": "ઘ (Totem Pole)", "hi": "टोटेम पोल"}'::jsonb, 'assets/images/countries_culture/totem_pole.png',
  '{"en": "Totem Pole! The tall carved wooden pillars of the Pacific Northwest Native peoples!", "gu": "ઘ (Totem Pole)! !", "hi": "टोटेम पोल! प्रशांत उत्तर-पश्चिम के मूल निवासी लोगों के ऊंचे नक्काशीदार लकड़ी के खंभे!"}'::jsonb,
  '{"en": "Totem poles are monumental carvings made from cedar trees by Indigenous peoples of the Pacific Northwest coast of Canada and USA. Each carved figure (animal or ancestral being) tells a story about a family''s history and heritage!", "gu": "ઘ (Totem poles) !, !, !", "hi": "टोटेम पोल कनाडा और अमेरिका के प्रशांत उत्तर-पश्चिमी तट के स्वदेशी लोगों द्वारा देवदार के पेड़ों से बनाई गई स्मारकीय नक्काशी हैं।"}'::jsonb,
  '{"en": "Did you know? The world''s tallest totem pole is 55 meters (180 feet) tall — about as high as a 15-storey building! It is located in Alert Bay, Canada.", "gu": "ઘ (Did you know)? 55 !, !", "hi": "क्या आपको पता है? दुनिया का सबसे ऊंचा टोटेम पोल 55 मीटर (180 फीट) ऊंचा है — लगभग एक 15 मंजिला इमारत जितना ऊंचा! यह कनाडा के अलर्ट बे में स्थित है।"}'::jsonb,
  'memory', true, 40
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

-- ===================== TRADITIONAL TRANSPORT =====================

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'gondola', (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Gondola", "gu": "ઘ (Gondola)", "hi": "गोंडोला"}'::jsonb, 'assets/images/countries_culture/gondola.png',
  '{"en": "Gondola! The elegant flat-bottomed boat of the canals of Venice, Italy!", "gu": "ઘ (Gondola)! !", "hi": "गोंडोला! वेनिस, इटली की नहरों की सुंदर सपाट तली वाली नाव!"}'::jsonb,
  '{"en": "A gondola is a traditional Venetian flat-bottomed boat steered by a gondolier (boatman) using a long oar. Venice, Italy has no roads — the streets are all water canals! Gondolas have been used in Venice for over 1,000 years.", "gu": "ઘ (Gondola) !, !, 1000 !", "hi": "गोंडोला एक पारंपरिक वेनेशियन सपाट तली वाली नाव है जिसे एक गोंडोलियर (नाविक) एक लंबे चप्पू का उपयोग करके चलाता है। वेनिस, इटली में कोई सड़कें नहीं हैं — सड़कें सभी जल नहरें हैं!"}'::jsonb,
  '{"en": "Did you know? Every gondola in Venice is traditionally painted black — there are about 400 gondolas still in use today, all handmade by master craftsmen!", "gu": "ઘ (Did you know)? 400 !, !", "hi": "क्या आपको पता है? वेनिस में हर गोंडोला परंपरागत रूप से काला रंगा जाता है — आज भी लगभग 400 गोंडोला उपयोग में हैं, सभी मास्टर कारीगरों द्वारा हस्तनिर्मित!"}'::jsonb,
  'memory', true, 41
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'rickshaw', (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Rickshaw", "gu": "ઘ (Rickshaw)", "hi": "रिक्शा"}'::jsonb, 'assets/images/countries_culture/rickshaw.png',
  '{"en": "Rickshaw! A hand-pulled cart used as a traditional taxi in parts of Asia!", "gu": "ઘ (Rickshaw)! !", "hi": "रिक्शा! एशिया के कुछ हिस्सों में पारंपरिक टैक्सी के रूप में इस्तेमाल की जाने वाली हाथ से खींची जाने वाली गाड़ी!"}'::jsonb,
  '{"en": "A rickshaw is a light two-wheeled passenger vehicle pulled by a person. It originated in Japan in the 1860s and became popular across Asia. Today, cycle rickshaws and auto-rickshaws are still common in India, Bangladesh, and China!", "gu": "ઘ (Rickshaw) 1860s !, !, !", "hi": "रिक्शा एक हल्का दो पहिया यात्री वाहन है जिसे एक व्यक्ति खींचता है। यह 1860 के दशक में जापान में उत्पन्न हुआ और पूरे एशिया में लोकप्रिय हो गया।"}'::jsonb,
  '{"en": "Did you know? The word ''rickshaw'' comes from the Japanese word ''jinrikisha'' meaning ''human-powered vehicle.'' Dhaka, Bangladesh has over 400,000 cycle rickshaws — the most in any city!", "gu": "ઘ (Did you know)? ''jinrikisha'' = ''human-powered vehicle'', !", "hi": "क्या आपको पता है? ''रिक्शा'' शब्द जापानी शब्द ''जिनरिक्शा'' से आया है जिसका अर्थ है ''मानव-संचालित वाहन।'' ढाका, बांग्लादेश में 4,00,000 से अधिक साइकिल रिक्शा हैं — किसी भी शहर में सबसे अधिक!"}'::jsonb,
  'memory', true, 42
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'tuk_tuk', (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Tuk-Tuk", "gu": "ઘ (Tuk-Tuk)", "hi": "टुक-टुक"}'::jsonb, 'assets/images/countries_culture/tuk_tuk.png',
  '{"en": "Tuk-Tuk! The colourful three-wheeled taxi buzzing through the streets of Thailand!", "gu": "ઘ (Tuk-Tuk)! !", "hi": "टुक-टुक! थाईलैंड की सड़कों पर भागने वाली रंगीन तीन पहिया टैक्सी!"}'::jsonb,
  '{"en": "The tuk-tuk (also auto-rickshaw) is a three-wheeled motorized taxi widely used in Thailand, India, Cambodia, and other Asian countries. They are famous for their colourful decorations and can zip through narrow streets that cars cannot enter!", "gu": "ઘ (Tuk-tuk) !, !", "hi": "टुक-टुक (ऑटो-रिक्शा भी) एक तीन पहिया मोटरयुक्त टैक्सी है जो थाईलैंड, भारत, कंबोडिया और अन्य एशियाई देशों में व्यापक रूप से उपयोग की जाती है।"}'::jsonb,
  '{"en": "Did you know? The name ''tuk-tuk'' comes from the sound of its engine — tuk, tuk, tuk! In Bangkok alone, there are over 10,000 tuk-tuks!", "gu": "ઘ (Did you know)? ''tuk-tuk'' = !, 10000 !", "hi": "क्या आपको पता है? ''टुक-टुक'' नाम उसके इंजन की आवाज से आता है — टुक, टुक, टुक! अकेले बैंकॉक में 10,000 से अधिक टुक-टुक हैं!"}'::jsonb,
  'memory', true, 43
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'bullock_cart', (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Bullock Cart", "gu": "ઘ (Bullock Cart)", "hi": "बैलगाड़ी"}'::jsonb, 'assets/images/countries_culture/bullock_cart.png',
  '{"en": "Bullock Cart! A traditional wooden cart pulled by oxen — used for thousands of years!", "gu": "ઘ (Bullock Cart)! !", "hi": "बैलगाड़ी! बैलों द्वारा खींची जाने वाली पारंपरिक लकड़ी की गाड़ी — हजारों वर्षों से उपयोग में!"}'::jsonb,
  '{"en": "A bullock cart is a vehicle pulled by bullocks (oxen). It has been used for thousands of years in South Asia, Southeast Asia, and Africa for transporting goods and people. Even today, many rural villages rely on bullock carts!", "gu": "ઘ (Bullock cart) !, !, !", "hi": "बैलगाड़ी बैलों द्वारा खींचा जाने वाला एक वाहन है। यह दक्षिण एशिया, दक्षिण-पूर्व एशिया और अफ्रीका में माल और लोगों के परिवहन के लिए हजारों वर्षों से उपयोग किया जाता रहा है।"}'::jsonb,
  '{"en": "Did you know? Bullock carts were the primary mode of transport for armies in ancient India — even Alexander the Great''s army used ox carts to carry supplies!", "gu": "ઘ (Did you know)? !, !", "hi": "क्या आपको पता है? बैलगाड़ी प्राचीन भारत में सेनाओं के लिए परिवहन का प्राथमिक साधन थी — यहां तक कि सिकंदर महान की सेना ने भी आपूर्ति ले जाने के लिए बैलगाड़ियों का उपयोग किया था!"}'::jsonb,
  'memory', true, 44
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'camel_cart', (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Camel Cart", "gu": "ઘ (Camel Cart)", "hi": "ऊंट गाड़ी"}'::jsonb, 'assets/images/countries_culture/camel_cart.png',
  '{"en": "Camel Cart! A colourful cart pulled by a camel — the ship of the desert!", "gu": "ઘ (Camel Cart)! !", "hi": "ऊंट गाड़ी! एक ऊंट द्वारा खींची जाने वाली रंगीन गाड़ी — रेगिस्तान का जहाज!"}'::jsonb,
  '{"en": "A camel cart is a traditional vehicle used across the deserts of Rajasthan (India), Pakistan, and Middle Eastern countries. Camels are called ''ships of the desert'' because they can travel for days without water, carrying heavy loads!", "gu": "ઘ (Camel cart) !, !", "hi": "ऊंट गाड़ी राजस्थान (भारत), पाकिस्तान और मध्य पूर्वी देशों के रेगिस्तानों में उपयोग किया जाने वाला एक पारंपरिक वाहन है।"}'::jsonb,
  '{"en": "Did you know? A camel can carry loads up to 450 kg (1,000 lbs) and travel 40 km (25 miles) per day in the desert — without needing a single drop of water for up to 2 weeks!", "gu": "ઘ (Did you know)? 450 kg, 40 km !, 2 !", "hi": "क्या आपको पता है? एक ऊंट 450 किग्रा (1,000 पाउंड) तक का भार उठा सकता है और रेगिस्तान में प्रतिदिन 40 किमी (25 मील) की यात्रा कर सकता है — 2 सप्ताह तक पानी की एक बूंद की जरूरत के बिना!"}'::jsonb,
  'memory', true, 45
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'dog_sled', (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Dog Sled", "gu": "ઘ (Dog Sled)", "hi": "कुत्ते की गाड़ी"}'::jsonb, 'assets/images/countries_culture/dog_sled.png',
  '{"en": "Dog Sled! A snow sled pulled by husky dogs — the transport of the Arctic!", "gu": "ઘ (Dog Sled)! !", "hi": "कुत्ते की गाड़ी! हस्की कुत्तों द्वारा खींची जाने वाली बर्फ की गाड़ी — आर्कटिक का परिवहन!"}'::jsonb,
  '{"en": "Dog sleds are a traditional form of transport used by Inuit and other Arctic peoples. Teams of strong husky dogs pull the sled across snow and ice. For thousands of years, dog sleds were the only way to travel across the frozen Arctic!", "gu": "ઘ (Dog sleds) !, !, !", "hi": "कुत्ते की गाड़ी इनुइट और अन्य आर्कटिक लोगों द्वारा उपयोग किए जाने वाले परिवहन का एक पारंपरिक रूप है। मजबूत हस्की कुत्तों की टीमें बर्फ और बर्फ के पार गाड़ी खींचती हैं।"}'::jsonb,
  '{"en": "Did you know? A team of sled dogs can run at speeds of up to 30 km/h (19 mph) and cover over 150 km (93 miles) in a single day in the Arctic cold!", "gu": "ઘ (Did you know)? 30 km/h, 150 km !", "hi": "क्या आपको पता है? स्लेज कुत्तों की एक टीम आर्कटिक की ठंड में 30 किमी/घंटा (19 मील प्रति घंटा) की गति से दौड़ सकती है और एक दिन में 150 किमी (93 मील) से अधिक की दूरी तय कर सकती है!"}'::jsonb,
  'memory', true, 46
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

-- ===================== MISC CULTURAL =====================

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'bamboo_basket', (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Bamboo Basket", "gu": "ઘ (Bamboo Basket)", "hi": "बांस की टोकरी"}'::jsonb, 'assets/images/countries_culture/bamboo_basket.png',
  '{"en": "Bamboo Basket! A traditional woven basket made from bamboo across Asia!", "gu": "ઘ (Bamboo Basket)! !", "hi": "बांस की टोकरी! एशिया भर में बांस से बनी पारंपरिक बुनी हुई टोकरी!"}'::jsonb,
  '{"en": "Bamboo baskets are handwoven containers made from strips of bamboo. They are used across Asia for carrying goods, storing food, and as household items. Bamboo is incredibly strong, flexible, and grows very fast — making it one of the most sustainable materials!", "gu": "ઘ (Bamboo baskets) !, !", "hi": "बांस की टोकरियां बांस की पट्टियों से हाथ से बुने गए कंटेनर हैं। वे एशिया भर में सामान ले जाने, भोजन संग्रहीत करने और घरेलू वस्तुओं के रूप में उपयोग किए जाते हैं।"}'::jsonb,
  '{"en": "Did you know? Bamboo is one of the fastest-growing plants on Earth — some species can grow up to 91 cm (3 feet) in a single day!", "gu": "ઘ (Did you know)? 91 cm !", "hi": "क्या आपको पता है? बांस पृथ्वी पर सबसे तेजी से बढ़ने वाले पौधों में से एक है — कुछ प्रजातियां एक ही दिन में 91 सेमी (3 फीट) तक बढ़ सकती हैं!"}'::jsonb,
  'memory', true, 47
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;

INSERT INTO public.countries_culture (topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order) VALUES (
  'pumpkin_lantern', (SELECT id FROM categories WHERE category_key = 'countries_culture' LIMIT 1),
  '{"en": "Jack-o''-Lantern", "gu": "ઘ (Jack-o''-Lantern)", "hi": "जैक-ओ-लालटेन"}'::jsonb, 'assets/images/countries_culture/pumpkin_lantern.png',
  '{"en": "Jack-o''-Lantern! The spooky carved pumpkin lit up for Halloween!", "gu": "ઘ (Jack-o''-Lantern)! !", "hi": "जैक-ओ-लालटेन! हैलोवीन के लिए जलाया जाने वाला डरावना नक्काशीदार कद्दू!"}'::jsonb,
  '{"en": "A jack-o''-lantern is a carved pumpkin with a face, lit from inside with a candle. It is a symbol of Halloween (October 31st), celebrated in the USA, Canada, Ireland, and UK. The tradition started in Ireland using carved turnips before pumpkins!", "gu": "ઘ (Jack-o''-lantern) !, !, !", "hi": "जैक-ओ-लालटेन एक नक्काशीदार कद्दू है जिसमें एक चेहरा है, अंदर से मोमबत्ती से जलाया गया है। यह हैलोवीन (31 अक्टूबर) का प्रतीक है, जिसे यूएसए, कनाडा, आयरलैंड और यूके में मनाया जाता है।"}'::jsonb,
  '{"en": "Did you know? The tradition of carving jack-o''-lanterns started over 2,000 years ago in Celtic Ireland, where people carved faces into turnips and potatoes to ward off evil spirits!", "gu": "ઘ (Did you know)? 2000 !, !", "hi": "क्या आपको पता है? जैक-ओ-लालटेन बनाने की परंपरा 2,000 से अधिक साल पहले सेल्टिक आयरलैंड में शुरू हुई, जहां लोग बुरी आत्माओं को दूर भगाने के लिए शलजम और आलू में चेहरे बनाते थे!"}'::jsonb,
  'memory', true, 48
) ON CONFLICT (topic_key) DO UPDATE SET category_id=EXCLUDED.category_id, name=EXCLUDED.name, image_path=EXCLUDED.image_path, narration=EXCLUDED.narration, explanation=EXCLUDED.explanation, fact=EXCLUDED.fact, display_order=EXCLUDED.display_order;
