-- 1. Create sports table and index
CREATE TABLE IF NOT EXISTS public.sports (
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
  constraint sports_pkey primary key (id),
  constraint sports_topic_key_key unique (topic_key),
  constraint sports_category_id_fkey foreign KEY (category_id) references categories (id) on delete CASCADE
) TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS idx_sports_topic_key on public.sports using btree (topic_key) TABLESPACE pg_default;

-- Disable Row Level Security (RLS) to fix private table access issues
ALTER TABLE public.sports DISABLE ROW LEVEL SECURITY;

-- Grant permissions to anonymous client keys
GRANT ALL ON public.sports TO anon;
GRANT ALL ON public.sports TO authenticated;
GRANT ALL ON public.sports TO service_role;

-- 2. Populate sports table with data
-- Using matching as the primary game type

-- ITEM ARCHERY
INSERT INTO public.sports 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'archery', 
  (SELECT id FROM categories WHERE category_key = 'sports' LIMIT 1), 
  '{"en": "Archery", "gu": "તીરંદાજી", "hi": "तीरंदाजी"}'::jsonb, 
  '/assets/images/sports/archery.png', 
  '{"en": "This is Archery. Archery is a sport where we shoot arrows at a target using a bow.", "gu": "આ તીરંદાજી છે. તીરંદાજી એ ધનુષનો ઉપયોગ કરીને લક્ષ્ય તરફ તીર ચલાવવાની રમત છે.", "hi": "यह तीरंदाजी है। तीरंदाजी धनुष का उपयोग करके लक्ष्य की ओर तीर चलाने का खेल है।"}'::jsonb, 
  '{"en": "Archers pull back the bowstring, aim at a round colorful board, and release the arrow. Hitting the yellow center gets the most points.", "gu": "તીરંદાજો ધનુષની દોરી ખેંચે છે, રંગબેરંગી બોર્ડ તરફ નિશાન સાધે છે અને તીર છોડે છે. પીળા કેન્દ્રમાં નિશાન લગાવવાથી સૌથી વધુ ગુણ મળે છે.", "hi": "तीरंदाज धनुष की डोरी खींचते हैं, रंग-बिरंगे बोर्ड पर निशाना साधते हैं और तीर छोड़ते हैं। पीले केंद्र पर निशाना लगाने से सबसे अधिक अंक मिलते हैं।"}'::jsonb, 
  '{"en": "Did you know? Archery is one of the oldest sports in the world, used for hunting thousands of years ago!", "gu": "શું તમે જાણો છો? તીરંદાજી એ વિશ્વની સૌથી જૂની રમતોમાંની એક છે, જેનો ઉપયોગ હજારો વર્ષ પહેલાં થતો હતો!", "hi": "क्या आप जानते हैं? तीरंदाजी दुनिया के सबसे पुराने खेलों में से एक है, जिसका उपयोग हजारों साल पहले किया जाता था!"}'::jsonb, 
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

-- ITEM BADMINTON
INSERT INTO public.sports 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'badminton', 
  (SELECT id FROM categories WHERE category_key = 'sports' LIMIT 1), 
  '{"en": "Badminton", "gu": "બેડમિન્ટન", "hi": "बैडमिंटन"}'::jsonb, 
  '/assets/images/sports/badminton.png', 
  '{"en": "This is Badminton. In badminton, we use rackets to hit a shuttlecock over a net.", "gu": "આ બેડમિન્ટન છે. બેડમિન્ટનમાં આપણે નેટની ઉપરથી ફૂલ (શટલકોક) ને રેકેટ વડે મારીએ છીએ.", "hi": "यह बैडमिंटन है। बैडमिंटन में हम नेट के ऊपर से शटलकॉक (चिड़िया) को रैकेट से मारते हैं।"}'::jsonb, 
  '{"en": "Badminton is played by two or four players. The shuttlecock is light and has feathers. Players try to prevent it from touching their floor.", "gu": "બેડમિન્ટન બે કે ચાર ખેલાડીઓ રમી શકે છે. શટલકોક ખૂબ હલકું અને પીંછાવાળું હોય છે. ખેલાડીઓ તેને જમીન પર પડવા દેતા નથી.", "hi": "बैडमिंटन दो या चार खिलाड़ी खेल सकते हैं। शटलकॉक बहुत हल्का और पंखदार होता है। खिलाड़ी इसे ज़मीन पर गिरने नहीं देते।"}'::jsonb, 
  '{"en": "Did you know? A shuttlecock is usually made from 16 feathers taken from the left wing of a goose!", "gu": "શું તમે જાણો છો? શટલકોક સામાન્ય રીતે હંસની ડાબી પાંખના ૧૬ પીંછાઓમાંથી બનાવવામાં આવે છે!", "hi": "क्या आप जानते हैं? शटलकॉक आमतौर पर बत्तख के बाएं पंख से लिए गए 16 पंखों से बनाया जाता है!"}'::jsonb, 
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

-- ITEM BASEBALL
INSERT INTO public.sports 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'baseball', 
  (SELECT id FROM categories WHERE category_key = 'sports' LIMIT 1), 
  '{"en": "Baseball", "gu": "બેઝબોલ", "hi": "बेसबॉल"}'::jsonb, 
  '/assets/images/sports/baseball.png', 
  '{"en": "This is Baseball. In baseball, we hit a small ball with a bat and run around bases.", "gu": "આ બેઝબોલ છે. બેઝબોલમાં આપણે બેટ વડે બોલને મારીએ છીએ અને બેઝની આસપાસ દોડીએ છીએ.", "hi": "यह बेसबॉल है। बेसबॉल में हम बल्ले से गेंद को मारते हैं और बेस के चारों ओर दौड़ते हैं।"}'::jsonb, 
  '{"en": "One player throws the ball, and another hits it with a wooden bat. The hitter runs around four bases to score a run. Players wear big gloves to catch the ball.", "gu": "એક ખેલાડી બોલ ફેંકે છે અને બીજો ખેલાડી તેને બેટ વડે ફટકારે છે. રન બનાવવા માટે ખેલાડી ચાર બેઝ પર દોડે છે. કેચ પકડવા તેઓ મોટા મોજા પહેરે છે.", "hi": "एक खिलाड़ी गेंद फेंकता है और दूसरा खिलाड़ी बल्ले से उसे मारता है। रन बनाने के लिए खिलाड़ी चार बेस पर दौड़ता है। कैच पकड़ने के लिए वे बड़े दस्ताने पहनते हैं।"}'::jsonb, 
  '{"en": "Did you know? Baseball is often called the national pastime of America!", "gu": "શું તમે જાણો છો? બેઝબોલને ઘણીવાર અમેરિકાની રાષ્ટ્રીય રમત માનવામાં આવે છે!", "hi": "क्या आप जानते हैं? बेसबॉल को अक्सर अमेरिका का राष्ट्रीय खेल माना जाता है!"}'::jsonb, 
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

-- ITEM BASKETBALL
INSERT INTO public.sports 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'basketball', 
  (SELECT id FROM categories WHERE category_key = 'sports' LIMIT 1), 
  '{"en": "Basketball", "gu": "બાસ્કેટબોલ", "hi": "बास्केटबॉल"}'::jsonb, 
  '/assets/images/sports/basketball.png', 
  '{"en": "This is Basketball. Basketball is a game where we bounce a ball and throw it into a hoop.", "gu": "આ બાસ્કેટબોલ છે. બાસ્કેટબોલમાં આપણે બોલને ડ્રિબલ (ટપ્પા મારીને) કરીને રિંગ (બાસ્કેટ) માં ફેંકીએ છીએ.", "hi": "यह बास्केटबॉल है। बास्केटबॉल में हम गेंद को ड्रिबल करके रिंग (बास्केट) में फेंकते हैं।"}'::jsonb, 
  '{"en": "Two teams play on a court. Players run, pass the ball to teammates, and jump high to shoot the ball into the orange hoop at the end of the court.", "gu": "કોર્ટ પર બે ટીમો રમે છે. ખેલાડીઓ દોડે છે, ટીમના સભ્યોને પાસ આપે છે અને ઊંચો કૂદકો મારીને ઓરેન્જ કલરની બાસ્કેટમાં બોલ નાખે છે.", "hi": "कोर्ट पर दो टीमें खेलती हैं। खिलाड़ी दौड़ते हैं, टीम के साथियों को पास देते हैं और ऊंची कूद लगाकर ऑरेंज बास्केट में गेंद डालते हैं।"}'::jsonb, 
  '{"en": "Did you know? In the first basketball games, players used peach baskets as hoops, and had to climb a ladder to get the ball back!", "gu": "શું તમે જાણો છો? પ્રથમ બાસ્કેટબોલ રમતમાં, ખેલાડીઓ ટોપલીનો ઉપયોગ રિંગ તરીકે કરતા અને બોલ કાઢવા માટે સીડી ચડવી પડતી!", "hi": "क्या आप जानते हैं? पहली बास्केटबॉल गेम में, खिलाड़ी टोकरियों का उपयोग रिंग के रूप में करते थे और गेंद निकालने के लिए सीढ़ी चढ़नी पड़ती थी!"}'::jsonb, 
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

-- ITEM BOXING
INSERT INTO public.sports 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'boxing', 
  (SELECT id FROM categories WHERE category_key = 'sports' LIMIT 1), 
  '{"en": "Boxing", "gu": "બોક્સિંગ", "hi": "मुक्केबाजी (बॉक्सिंग)"}'::jsonb, 
  '/assets/images/sports/boxing.png', 
  '{"en": "This is Boxing. Boxing is a sport where two players wear soft gloves and face each other in a ring.", "gu": "આ બોક્સિંગ છે. બોક્સિંગ એ એવી રમત છે જ્યાં બે ખેલાડીઓ નરમ મોજા પહેરે છે અને સામસામે સ્પર્ધા કરે છે.", "hi": "यह मुक्केबाजी है। मुक्केबाजी ऐसा खेल है जहाँ दो खिलाड़ी नरम दस्ताने पहनते हैं और आमने-सामने मुकाबला करते हैं।"}'::jsonb, 
  '{"en": "Boxers use punches to score points. They wear mouthguards and headguards to stay safe. They train to be very fast and strong.", "gu": "બોક્સરો પોઈન્ટ મેળવવા મુક્કા (પંચ) નો ઉપયોગ કરે છે. સુરક્ષિત રહેવા માટે તેઓ માઉથગાર્ડ અને હેડગાર્ડ પહેરે છે. તેઓ ખૂબ ઝડપી તાલીમ મેળવે છે.", "hi": "मुक्केबाज अंक प्राप्त करने के लिए मुक्कों (पंच) का उपयोग करते हैं। सुरक्षित रहने के लिए वे माउथगार्ड और हेडगार्ड पहनते हैं।"}'::jsonb, 
  '{"en": "Did you know? Boxing has been an Olympic sport since ancient Greece over 2,600 years ago!", "gu": "શું તમે જાણો છો? બોક્સિંગ ૨,૬૦૦ વર્ષથી વધુ સમય પહેલા પ્રાચીન ગ્રીસથી ઓલિમ્પિક રમત છે!", "hi": "क्या आप जानते हैं? मुक्केबाजी 2,600 साल से अधिक समय पहले प्राचीन ग्रीस से ओलंपिक खेल है!"}'::jsonb, 
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

-- ITEM CHESS
INSERT INTO public.sports 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'chess', 
  (SELECT id FROM categories WHERE category_key = 'sports' LIMIT 1), 
  '{"en": "Chess", "gu": "ચેસ", "hi": "शतरंज"}'::jsonb, 
  '/assets/images/sports/chess.png', 
  '{"en": "This is Chess. Chess is a smart board game played with black and white pieces.", "gu": "આ ચેસ છે. ચેસ એ કાળા અને સફેદ રંગના મહોરાઓ સાથે રમાતી બુદ્ધિશાળી બોર્ડ ગેમ છે.", "hi": "यह शतरंज है। शतरंज काले और सफेद मोहरों के साथ खेला जाने वाला एक बुद्धिमान बोर्ड गेम है।"}'::jsonb, 
  '{"en": "Two players use strategy to move their pieces like knights, bishops, and the king. The goal is to trap the opponent''s king, called checkmate.", "gu": "બે ખેલાડીઓ ઘોડો, હાથી, વજીર અને રાજા જેવા મહોરાઓને ચલાવવા માટે વ્યૂહરચના વાપરે છે. ધ્યેય રાજાને હરાવવાનો છે, જેને ચેકમેટ કહેવાય છે.", "hi": "दो खिलाड़ी घोड़ा, ऊँट, वज़ीर और राजा जैसे मोहरों को चलाने के लिए रणनीति का उपयोग करते हैं। लक्ष्य राजा को हराना होता है, जिसे शह और मात (चेकमेट) कहते हैं।"}'::jsonb, 
  '{"en": "Did you know? Chess was invented in India over 1,500 years ago, and it was originally called Chaturanga!", "gu": "શું તમે જાણો છો? ચેસની શોધ ૧,૫૦૦ વર્ષ પહેલાં ભારતમાં થઈ હતી, અને તેને મૂળરૂપે ચતુરંગ કહેવામાં આવતું હતું!", "hi": "क्या आप जानते हैं? शतरंज का आविष्कार 1,500 साल से पहले भारत में हुआ था, और इसे मूल रूप से चतुरंग कहा जाता था!"}'::jsonb, 
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

-- ITEM CRICKET
INSERT INTO public.sports 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'cricket', 
  (SELECT id FROM categories WHERE category_key = 'sports' LIMIT 1), 
  '{"en": "Cricket", "gu": "ક્રિકેટ", "hi": "क्रिकेट"}'::jsonb, 
  '/assets/images/sports/cricket.png', 
  '{"en": "This is Cricket. In cricket, we hit a leather ball with a bat and run between wickets.", "gu": "આ ક્રિકેટ છે. ક્રિકેટમાં આપણે બેટ વડે લેધરના બોલને ફટકારે છે અને વિકેટો વચ્ચે દોડીએ છીએ.", "hi": "यह क्रिकेट है। क्रिकेट में हम बल्ले से चमड़े की गेंद को मारते हैं और विकेटों के बीच दौड़ते हैं।"}'::jsonb, 
  '{"en": "A bowler throws the ball, and a batsman hits it to score runs. If the ball hits the wickets, the batsman is out. It is played by two teams.", "gu": "બોલર બોલ ફેંકે છે અને બેટ્સમેન રન બનાવવા માટે તેને હિટ કરે છે. જો બોલ વિકેટને અડે તો બેટ્સમેન આઉટ ગણાય છે. તે બે ટીમો વચ્ચે રમાય છે.", "hi": "गेंदबाज़ गेंद फेंकता है और बल्लेबाज़ रन बनाने के लिए उसे मारता है। यदि गेंद विकेट पर लगती है तो बल्लेबाज़ आउट हो जाता है। यह दो टीमों के बीच खेला जाता है।"}'::jsonb, 
  '{"en": "Did you know? The longest cricket match in history lasted for 9 days, and still ended in a draw!", "gu": "શું તમે જાણો છો? ઇતિહાસમાં સૌથી લાંબી ક્રિકેટ મેચ ૯ દિવસ સુધી ચાલી હતી, છતાં ડ્રોમાં સમાપ્ત થઈ હતી!", "hi": "क्या आप जानते हैं? इतिहास का सबसे लंबा क्रिकेट मैच 9 दिनों तक चला था, फिर भी ड्रॉ पर समाप्त हुआ!"}'::jsonb, 
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

-- ITEM CYCLING
INSERT INTO public.sports 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'cycling', 
  (SELECT id FROM categories WHERE category_key = 'sports' LIMIT 1), 
  '{"en": "Cycling", "gu": "સાયકલિંગ", "hi": "साइकिल चलाना"}'::jsonb, 
  '/assets/images/sports/cycling.png', 
  '{"en": "This is Cycling. Cycling is racing or riding bicycles on roads and tracks.", "gu": "આ સાયકલિંગ છે. સાયકલિંગ એ રસ્તાઓ અને ટ્રેક પર સાયકલ ચલાવવાની અથવા રેસ કરવાની રમત છે.", "hi": "यह साइकिल चलाना है। साइकिल चलाना सड़कों और ट्रैक पर साइकिल चलाने या रेस लगाने का खेल है।"}'::jsonb, 
  '{"en": "Cyclists pedal fast to move forward. They race in groups, and the first to cross the finish line wins. It builds very strong leg muscles.", "gu": "સાયકલ સવારો આગળ વધવા માટે ઝડપથી પેડલ મારે છે. તેઓ જૂથમાં રેસ કરે છે અને અંતિમ રેખા પાર કરનાર વિજેતા બને છે.", "hi": "साइकिल चालक आगे बढ़ने के लिए तेज़ी से पैडल मारते हैं। वे समूह में रेस लगाते हैं और फिनिश लाइन पार करने वाला विजेता बनता है।"}'::jsonb, 
  '{"en": "Did you know? The Tour de France is the most famous bicycle race in the world, lasting over three weeks!", "gu": "શું તમે જાણો છો? ટૂર ડી ફ્રાન્સ એ વિશ્વની સૌથી પ્રખ્યાત સાયકલ રેસ છે, જે ત્રણ અઠવાડિયાથી વધુ ચાલે છે!", "hi": "क्या आप जानते हैं? टूर डी फ्रांस दुनिया की सबसे प्रसिद्ध साइकिल रेस है, जो तीन सप्ताह से अधिक चलती है!"}'::jsonb, 
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

-- ITEM FIELD HOCKEY
INSERT INTO public.sports 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'field_hockey', 
  (SELECT id FROM categories WHERE category_key = 'sports' LIMIT 1), 
  '{"en": "Field Hockey", "gu": "હોકી", "hi": "हॉकी"}'::jsonb, 
  '/assets/images/sports/field_hockey.png', 
  '{"en": "This is Field Hockey. In hockey, we use curved sticks to hit a ball into a goal.", "gu": "આ હોકી છે. હોકીમાં આપણે બોલને ગોલપોસ્ટમાં નાખવા માટે વળાંકવાળી લાકડીઓ (હોકી સ્ટિક) નો ઉપયોગ કરીએ છીએ.", "hi": "यह हॉकी है। हॉकी में हम गेंद को गोल में डालने के लिए मुड़ी हुई छड़ियों (हॉकी स्टिक) का उपयोग करते हैं।"}'::jsonb, 
  '{"en": "Players run fast on a grassy field, passing the ball to teammates. They use the flat side of the hockey stick to control and shoot the ball.", "gu": "ખેલાડીઓ ઘાસવાળા મેદાન પર ઝડપથી દોડે છે અને સાથી ખેલાડીઓને પાસ આપે છે. બોલને નિયંત્રિત કરવા તેઓ હોકી સ્ટિકનો ઉપયોગ કરે છે.", "hi": "खिलाड़ी घास के मैदान पर तेज़ी से दौड़ते हैं और साथी खिलाड़ियों को पास देते हैं। गेंद को नियंत्रित करने के लिए वे हॉकी स्टिक का उपयोग करते हैं।"}'::jsonb, 
  '{"en": "Did you know? Hockey is the national game of India, and India has won many Olympic gold medals in it!", "gu": "શું તમે જાણો છો? હોકી એ ભારતની રાષ્ટ્રીય રમત છે અને ભારતે તેમાં ઓલિમ્પિકમાં ઘણા ગોલ્ડ મેડલ જીત્યા છે!", "hi": "क्या आप जानते हैं? हॉकी भारत का राष्ट्रीय खेल है और भारत ने इसमें ओलंपिक में कई स्वर्ण पदक जीते हैं!"}'::jsonb, 
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

-- ITEM FOOTBALL
INSERT INTO public.sports 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'football', 
  (SELECT id FROM categories WHERE category_key = 'sports' LIMIT 1), 
  '{"en": "Football", "gu": "ફૂટબોલ", "hi": "फुटबॉल"}'::jsonb, 
  '/assets/images/sports/football.png', 
  '{"en": "This is Football. In football, we kick a round ball to score goals in the opponent''s net.", "gu": "આ ફૂટબોલ છે. ફૂટબોલમાં આપણે ગોલ કરવા માટે પગથી દડાને વિરોધી ટીમની જાળીમાં કિક મારીએ છીએ.", "hi": "यह फुटबॉल है। फुटबॉल में हम गोल करने के लिए पैर से गेंद को विरोधी टीम की जाली में किक मारते हैं।"}'::jsonb, 
  '{"en": "Two teams play on a large green field. Players use only their feet and head to move the ball. Only the goalkeeper can use hands.", "gu": "મોટા લીલા મેદાન પર બે ટીમો રમે છે. ખેલાડીઓ બોલ ખસેડવા માટે માત્ર તેમના પગ અને માથાનો ઉપયોગ કરે છે. ફક્ત ગોલકીપર હાથ વાપરી શકે છે.", "hi": "बड़े हरे मैदान पर दो टीमें खेलती हैं। खिलाड़ी गेंद को बढ़ाने के लिए केवल अपने पैरों और सिर का उपयोग करते हैं। केवल गोलकीपर हाथ का उपयोग कर सकता है।"}'::jsonb, 
  '{"en": "Did you know? Football is the most popular sport in the world, watched by billions of people!", "gu": "શું તમે જાણો છો? ફૂટબોલ એ વિશ્વની સૌથી લોકપ્રિય રમત છે, જે અબજો લોકો દ્વારા જોવામાં આવે છે!", "hi": "क्या आप जानते हैं? फुटबॉल दुनिया का सबसे लोकप्रिय खेल है, जिसे अरबों लोगों द्वारा देखा जाता है!"}'::jsonb, 
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

-- ITEM GOLF
INSERT INTO public.sports 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'golf', 
  (SELECT id FROM categories WHERE category_key = 'sports' LIMIT 1), 
  '{"en": "Golf", "gu": "ગોલ્ફ", "hi": "गोल्फ"}'::jsonb, 
  '/assets/images/sports/golf.png', 
  '{"en": "This is Golf. In golf, we hit a small white ball with clubs into holes on a grassy field.", "gu": "આ ગોલ્ફ છે. ગોલ્ફમાં આપણે ક્લબ (ખાસ સ્ટીક) વડે નાની સફેદ બોલને ઘાસવાળા મેદાનમાં બનાવેલા ખાડાઓમાં ફટકારે છે.", "hi": "यह गोल्फ है। गोल्फ में हम क्लब (विशेष छड़ी) से छोटी सफेद गेंद को मैदान में बने छिद्रों में मारते हैं।"}'::jsonb, 
  '{"en": "Golf is a quiet and precise game. The player who gets the ball into all 18 holes with the fewest hits wins the game.", "gu": "ગોલ્ફ એ શાંતિપૂર્ણ અને ચોકસાઈની રમત છે. જે ખેલાડી સૌથી ઓછા શોટ્સ સાથે બોલને ૧૮ ખાડાઓમાં નાખે છે તે વિજેતા બને છે.", "hi": "गोल्फ एक शांत और सटीकता का खेल है। जो खिलाड़ी सबसे कम शॉट्स के साथ गेंद को सभी 18 छिद्रों में डालता है, वह विजेता बनता है।"}'::jsonb, 
  '{"en": "Did you know? Golf is one of the only sports that has been played on the moon, when an astronaut hit a ball in 1971!", "gu": "શું તમે જાણો છો? ચંદ્ર પર રમાયેલી એકમાત્ર રમત ગોલ્ફ છે, જ્યારે ૧૯૭૧ માં અવકાશયાત્રીએ ત્યાં બોલ ફટકાર્યો હતો!", "hi": "क्या आप जानते हैं? चंद्रमा पर खेला जाने वाला एकमात्र खेल गोल्फ है, जब 1971 में एक अंतरिक्ष यात्री ने वहां गेंद को मारा था!"}'::jsonb, 
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

-- ITEM GYMNASTICS
INSERT INTO public.sports 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'gymnastics', 
  (SELECT id FROM categories WHERE category_key = 'sports' LIMIT 1), 
  '{"en": "Gymnastics", "gu": "જિમ્નાસ્ટિક્સ", "hi": "जिमनैस्टिक"}'::jsonb, 
  '/assets/images/sports/gymnastics.png', 
  '{"en": "This is Gymnastics. In gymnastics, we perform flips, jumps, and balances with our bodies.", "gu": "આ જિમ્નાસ્ટિક્સ છે. જિમ્નાસ્ટિક્સમાં આપણે આપણા શરીરથી પલટી મારીએ છીએ, કૂદીએ છીએ અને સંતુલન રાખીએ છીએ.", "hi": "यह जिमनैस्टिक है। जिमनैस्टिक में हम अपने शरीर से कलाबाज़ी खाते हैं, कूदते हैं और संतुलन बनाते हैं।"}'::jsonb, 
  '{"en": "Gymnasts train to be extremely flexible and strong. They perform on beams, bars, and floor mats, showing beautiful moves.", "gu": "જિમ્નાસ્ટો ખૂબ જ લવચીક અને મજબૂત બનવા માટે તાલીમ મેળવે છે. તેઓ બીમ, સળિયા અને ફ્લોર મેટ્સ પર સુંદર પ્રદર્શન કરે છે.", "hi": "जिमनास्ट बहुत अधिक लचीले और मजबूत होने की ट्रेनिंग लेते हैं। वे बीम, सलाखों और फर्श पर सुंदर प्रदर्शन करते हैं।"}'::jsonb, 
  '{"en": "Did you know? Gymnastics originally started in ancient Greece as a way to train soldiers for war!", "gu": "શું તમે જાણો છો? જિમ્નાસ્ટિક્સની શરૂઆત પ્રાચીન ગ્રીસમાં સૈનિકોને યુદ્ધ માટે તાલીમ આપવા માટે થઈ હતી!", "hi": "क्या आप जानते हैं? जिमनैस्टिक की शुरुआत प्राचीन ग्रीस में सैनिकों को युद्ध के लिए प्रशिक्षित करने के रूप में हुई थी!"}'::jsonb, 
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

-- ITEM JUDO
INSERT INTO public.sports 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'judo', 
  (SELECT id FROM categories WHERE category_key = 'sports' LIMIT 1), 
  '{"en": "Judo", "gu": "જુડો", "hi": "जूडो"}'::jsonb, 
  '/assets/images/sports/judo.png', 
  '{"en": "This is Judo. Judo is a martial art sport about throwing and holding opponents on a mat.", "gu": "આ જુડો છે. જુડો એ માર્શલ આર્ટની રમત છે જેમાં સાથી ખેલાડીને મેટ પર પછાડીને નિયંત્રિત કરવાનો હોય છે.", "hi": "यह जूडो है। जूडो एक मार्शल आर्ट खेल है जिसमें विरोधी खिलाड़ी को मैट पर गिराकर नियंत्रित करना होता है।"}'::jsonb, 
  '{"en": "Judo means ''gentle way''. Players wear a white uniform called a gi and a belt. They use their opponent''s weight to defend themselves safely.", "gu": "જુડોનો અર્થ ''નમ્ર માર્ગ'' થાય છે. ખેલાડીઓ સફેદ યુનિફોર્મ (જી) અને બેલ્ટ પહેરે છે. તેઓ બચાવ માટે વિરોધીના વજનનો ઉપયોગ કરે છે.", "hi": "जूडो का अर्थ ''सौम्य तरीका'' होता है। खिलाड़ी सफेद यूनिफॉर्म (गी) और बेल्ट पहनते हैं। वे बचाव के लिए विरोधी के वजन का उपयोग करते हैं।"}'::jsonb, 
  '{"en": "Did you know? In Judo, the color of your belt shows how much you have learned, starting with white and going to black!", "gu": "શું તમે જાણો છો? જુડોમાં, બેલ્ટનો રંગ તમે કેટલું શીખ્યા છો તે દર્શાવે છે, જે સફેદથી શરૂ થઈને બ્લેક સુધી જાય છે!", "hi": "क्या आप जानते हैं? जूडो में, बेल्ट का रंग दर्शाता है कि आपने कितना सीखा है, जो सफेद से शुरू होकर ब्लैक तक जाता है!"}'::jsonb, 
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

-- ITEM KARATE
INSERT INTO public.sports 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'karate', 
  (SELECT id FROM categories WHERE category_key = 'sports' LIMIT 1), 
  '{"en": "Karate", "gu": "કરાટે", "hi": "कराटे"}'::jsonb, 
  '/assets/images/sports/karate.png', 
  '{"en": "This is Karate. Karate is a martial art that uses punches, kicks, and blocks.", "gu": "આ કરાટે છે. કરાટે એ માર્શલ આર્ટ છે જે મુક્કા, લાત અને બચાવના દાવપેચનો ઉપયોગ કરે છે.", "hi": "यह कराटे है। कराटे एक मार्शल आर्ट है जो मुक्कों, लातों और बचाव के तरीकों का उपयोग करता है।"}'::jsonb, 
  '{"en": "Karate helps us learn self-defense and build focus. It requires lots of discipline and respect. Players practice moves called kata.", "gu": "કરાટે આપણને આત્મરક્ષણ શીખવામાં અને એકાગ્રતા વધારવામાં મદદ કરે છે. તેમાં ઘણી શિસ્ત અને આદરની જરૂર હોય છે.", "hi": "कराटे हमें आत्मरक्षा सीखने और ध्यान केंद्रित करने में मदद करता है। इसमें बहुत अनुशासन और सम्मान की आवश्यकता होती है।"}'::jsonb, 
  '{"en": "Did you know? The word ''Karate'' means ''empty hand'' in Japanese, because players do not use any weapons!", "gu": "શું તમે જાણો છો? કરાટે શબ્દનો અર્થ જાપાનીઝમાં ''ખાલી હાથ'' થાય છે, કારણ કે ખેલાડીઓ કોઈ હથિયાર વાપરતા નથી!", "hi": "क्या आप जानते हैं? कराटे शब्द का अर्थ जापानी में ''खाली हाथ'' होता है, क्योंकि खिलाड़ी किसी हथियार का उपयोग नहीं करते!"}'::jsonb, 
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

-- ITEM RUGBY
INSERT INTO public.sports 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'rugby', 
  (SELECT id FROM categories WHERE category_key = 'sports' LIMIT 1), 
  '{"en": "Rugby", "gu": "રગ્બી", "hi": "रग्बी"}'::jsonb, 
  '/assets/images/sports/rugby.png', 
  '{"en": "This is Rugby. Rugby is a team sport played with an oval ball that we run and pass.", "gu": "આ રગ્બી છે. રગ્બી એ અંડાકાર દડા સાથે રમાતી રમત છે જેને ખેલાડીઓ હાથમાં પકડીને દોડે છે અને પાસ કરે છે.", "hi": "यह रग्बी है। रग्बी एक अंडाकार गेंद के साथ खेला जाने वाला खेल है जिसे खिलाड़ी हाथ में लेकर दौड़ते और पास करते हैं।"}'::jsonb, 
  '{"en": "Players run forward but can only pass the ball backward. They tackle opponents to stop them and try to touch the ball to the ground behind the line.", "gu": "ખેલાડીઓ આગળ દોડે છે પણ બોલ માત્ર પાછળ જ પાસ કરી શકે છે. તેઓ વિરોધીને રોકવા માટે પકડે છે અને લાઇન પાછળ બોલને અડાડે છે.", "hi": "खिलाड़ी आगे दौड़ते हैं लेकिन गेंद केवल पीछे ही पास कर सकते हैं। वे विरोधी को रोकने के लिए पकड़ते हैं और लाइन के पीछे गेंद को छूते हैं।"}'::jsonb, 
  '{"en": "Did you know? A rugby ball is oval-shaped because the first balls were made from pig bladders, which were naturally oval!", "gu": "શું તમે જાણો છો? રગ્બીનો દડો અંડાકાર હોય છે કારણ કે પ્રથમ બોલ પ્રાણીઓના અંગમાંથી બનાવાયા હતા જે કુદરતી રીતે અંડાકાર હતા!", "hi": "क्या आप जानते हैं? रग्बी की गेंद अंडाकार होती है क्योंकि पहली गेंदें जानवरों के अंगों से बनाई गई थीं जो प्राकृतिक रूप से अंडाकार थीं!"}'::jsonb, 
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

-- ITEM SKATING
INSERT INTO public.sports 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'skating', 
  (SELECT id FROM categories WHERE category_key = 'sports' LIMIT 1), 
  '{"en": "Skating", "gu": "સ્કેટિંગ", "hi": "स्केटिंग"}'::jsonb, 
  '/assets/images/sports/skating.png', 
  '{"en": "This is Skating. Skating is rolling on the ground using boots with wheels.", "gu": "આ સ્કેટિંગ છે. સ્કેટિંગ એ પૈડાંવાળા બૂટ પહેરીને જમીન પર લપસવાની રમત છે.", "hi": "यह स्केटिंग है। स्केटिंग पहियों वाले बूट पहनकर ज़मीन पर फिसलने का खेल है।"}'::jsonb, 
  '{"en": "Skaters balance on roller skates or inline skates. They glide smoothly, perform turns, and can travel very fast on flat surfaces.", "gu": "સ્કેટર્સ રોલર સ્કેટ્સ પર પોતાનું સંતુલન જાળવે છે. તેઓ સપાટ રસ્તાઓ પર સરળતાથી લપસીને ખૂબ ઝડપથી આગળ વધી શકે છે.", "hi": "स्केटर रोलर स्केट्स पर अपना संतुलन बनाते हैं। वे सपाट रास्तों पर आसानी से फिसलकर बहुत तेज़ गति से आगे बढ़ सकते हैं।"}'::jsonb, 
  '{"en": "Did you know? The first roller skates were invented in Belgium, but they had no brakes, so the inventor crashed into a mirror!", "gu": "શું તમે જાણો છો? બેલ્જિયમમાં શોધાયેલા પ્રથમ સ્કેટ્સમાં બ્રેક નહોતી, જેથી શોધક અરીસા સાથે અથડાઈ ગયો હતો!", "hi": "क्या आप जानते हैं? बेल्जियम में आविष्कार किए गए पहले स्केट्स में ब्रेक नहीं थे, जिससे आविष्कारक एक शीशे से टकरा गया था!"}'::jsonb, 
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

-- ITEM SKIING
INSERT INTO public.sports 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'skiing', 
  (SELECT id FROM categories WHERE category_key = 'sports' LIMIT 1), 
  '{"en": "Skiing", "gu": "સ્કીઇંગ", "hi": "स्कीइंग"}'::jsonb, 
  '/assets/images/sports/skiing.png', 
  '{"en": "This is Skiing. Skiing is gliding down snowy mountains on long, flat boards.", "gu": "આ સ્કીઇંગ છે. સ્કીઇંગ એ લાંબા, સપાટ પાટિયા (સ્કીઝ) પર બરફવાળા પર્વતો પરથી નીચે લપસવાની રમત છે.", "hi": "यह स्कीइंग है। स्कीइंग लंबे, चपटे तख्तों पर बर्फबारी वाले पहाड़ों से नीचे फिसलने का खेल है।"}'::jsonb, 
  '{"en": "Skiiers wear warm clothes and boots attached to skis. They use two poles to balance and steer around turns down the snowy slopes.", "gu": "સ્કીઅર્સ ગરમ કપડાં અને સ્કી સાથે જોડાયેલા બૂટ પહેરે છે. તેઓ બરફીલા ઢોળાવ પર સંતુલન રાખવા માટે બે લાકડીઓનો ઉપયોગ કરે છે.", "hi": "स्कीयर गर्म कपड़े और स्की से जुड़े बूट पहनते हैं। वे बर्फीले ढलानों पर संतुलन बनाए रखने के लिए दो छड़ियों का उपयोग करते हैं।"}'::jsonb, 
  '{"en": "Did you know? Skiing was used thousands of years ago in cold countries as a way to travel across snow, not just for sport!", "gu": "શું તમે જાણો છો? હજારો વર્ષ પહેલાં ઠંડા દેશોમાં બરફ પર મુસાફરી કરવાના સાધન તરીકે સ્કીઇંગનો ઉપયોગ થતો હતો!", "hi": "क्या आप जानते हैं? हजारों साल पहले ठंडे देशों में बर्फ पर यात्रा करने के साधन के रूप में स्कीइंग का उपयोग किया जाता था!"}'::jsonb, 
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

-- ITEM SURFING
INSERT INTO public.sports 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'surfing', 
  (SELECT id FROM categories WHERE category_key = 'sports' LIMIT 1), 
  '{"en": "Surfing", "gu": "સર્ફિંગ", "hi": "सर्फिंग"}'::jsonb, 
  '/assets/images/sports/surfing.png', 
  '{"en": "This is Surfing. Surfing is riding on ocean waves using a surfboard.", "gu": "આ સર્ફિંગ છે. સર્ફિંગ એ સર્ફબોર્ડની મદદથી સમુદ્રના મોજાં પર સવારી કરવાની રમત છે.", "hi": "यह सर्फिंग है। सर्फिंग एक सर्फबोर्ड की मदद से समुद्र की लहरों पर सवारी करने का खेल है।"}'::jsonb, 
  '{"en": "Surfers paddle out into the ocean, stand up on a long fiberglass board, and balance carefully as they slide down a rolling wave.", "gu": "સર્ફર્સ સમુદ્રમાં જાય છે, લાંબા બોર્ડ પર ઊભા રહે છે અને પાણીના મોજાની સાથે સંતુલન જાળવીને આગળ વધે છે.", "hi": "सर्फर समुद्र में जाते हैं, लंबे बोर्ड पर खड़े होते हैं और पानी की लहरों के साथ संतुलन बनाकर आगे बढ़ते हैं।"}'::jsonb, 
  '{"en": "Did you know? Surfing was invented in Hawaii, where it was called ''he''e nalu'', meaning wave sliding!", "gu": "શું તમે જાણો છો? સર્ફિંગની શોધ હવાઈમાં થઈ હતી, જ્યાં તેને ''હે અ નાલુ'' કહેવામાં આવતું હતું, જેનો અર્થ મોજા પર લપસવું થાય છે!", "hi": "क्या आप जानते हैं? सर्फिंग का आविष्कार हवाई में हुआ था, जहाँ इसे ''हे ए नालू'' कहा जाता था, जिसका अर्थ लहरों पर फिसलना होता है!"}'::jsonb, 
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

-- ITEM SWIMMING
INSERT INTO public.sports 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'swimming', 
  (SELECT id FROM categories WHERE category_key = 'sports' LIMIT 1), 
  '{"en": "Swimming", "gu": "સ્વિમિંગ", "hi": "तैराकी"}'::jsonb, 
  '/assets/images/sports/swimming.png', 
  '{"en": "This is Swimming. Swimming is moving through water using our arms and legs.", "gu": "આ સ્વિમિંગ (તરવું) છે. સ્વિમિંગ એ આપણા હાથ અને પગનો ઉપયોગ કરીને પાણીમાં આગળ વધવાની રમત છે.", "hi": "यह तैराकी है। तैराकी हमारे हाथ और पैर का उपयोग करके पानी में आगे बढ़ने का खेल है।"}'::jsonb, 
  '{"en": "Swimmers wear goggles and caps. They do strokes like freestyle or backstroke to glide through the pool. It is a great way to cool off in summer.", "gu": "તરવૈયાઓ ચશ્મા અને કેપ પહેરે છે. તેઓ પુલમાં આગળ વધવા માટે ફ્રીસ્ટાઇલ અથવા બેકસ્ટ્રોક કરે છે. તે ઉનાળામાં ગરમીથી બચવા માટે શ્રેષ્ઠ છે.", "hi": "तैराक चश्मा और कैप पहनते हैं। वे पूल में आगे बढ़ने के लिए फ्रीस्टाइल या बैकस्ट्रोक करते हैं। यह गर्मियों में गर्मी से बचने का बेहतरीन तरीका है।"}'::jsonb, 
  '{"en": "Did you know? Swimming is one of the best exercises because it uses almost every muscle in your body!", "gu": "શું તમે જાણો છો? તરવું એ શ્રેષ્ઠ કસરતોમાંની એક છે કારણ કે તેમાં શરીરના લગભગ દરેક સ્નાયુનો ઉપયોગ થાય છે!", "hi": "क्या आप जानते हैं? तैरना सबसे अच्छे व्यायामों में से एक है क्योंकि इसमें शरीर की लगभग हर मांसपेशी का उपयोग होता है!"}'::jsonb, 
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

-- ITEM TABLE TENNIS
INSERT INTO public.sports 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'table_tennis', 
  (SELECT id FROM categories WHERE category_key = 'sports' LIMIT 1), 
  '{"en": "Table Tennis", "gu": "ટેબલ ટેનિસ", "hi": "टेबल टेनिस"}'::jsonb, 
  '/assets/images/sports/table_tennis.png', 
  '{"en": "This is Table Tennis. In table tennis, we hit a tiny ball over a net on a flat table.", "gu": "આ ટેબલ ટેનિસ છે. ટેબલ ટેનિસમાં આપણે એક સપાટ ટેબલ પર રહેલી નેટ પરથી નાની બોલને હિટ કરીએ છીએ.", "hi": "यह टेबल टेनिस है। टेबल टेनिस में हम एक फ्लैट टेबल पर नेट के ऊपर से एक छोटी गेंद को हिट करते हैं।"}'::jsonb, 
  '{"en": "It is also called ping pong. Players use small wooden paddles to bounce a lightweight hollow ball back and forth very fast.", "gu": "તેને પિંગ પોંગ પણ કહેવામાં આવે છે. ખેલાડીઓ હલકી અને ખોખલી બોલને ઝડપથી ફટકારવા માટે લાકડાના નાના રેકેટ (પૅડલ્સ) નો ઉપયોગ કરે છે.", "hi": "इसे पिंग पोंग भी कहा जाता है। खिलाड़ी हल्की गेंद को तेज़ी से मारने के लिए लकड़ी के छोटे रैकेट का उपयोग करते हैं।"}'::jsonb, 
  '{"en": "Did you know? The ball in table tennis can travel at speeds of over 70 miles per hour during professional games!", "gu": "શું તમે જાણો છો? પ્રોફેશનલ રમતો દરમિયાન ટેબલ ટેનિસનો બોલ કલાકના ૭૦ માઇલથી વધુની ઝડપે મુસાફરી કરી શકે છે!", "hi": "क्या आप जानते हैं? पेशेवर खेलों के दौरान टेबल टेनिस की गेंद 70 मील प्रति घंटे से अधिक की गति से यात्रा कर सकती है!"}'::jsonb, 
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

-- ITEM TAEKWONDO
INSERT INTO public.sports 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'taekwondo', 
  (SELECT id FROM categories WHERE category_key = 'sports' LIMIT 1), 
  '{"en": "Taekwondo", "gu": "તાઈકવન્ડો", "hi": "ताइक्वांडो"}'::jsonb, 
  '/assets/images/sports/taekwondo.png', 
  '{"en": "This is Taekwondo. Taekwondo is a martial art famous for fast and high kicks.", "gu": "આ તાઈકવન્ડો છે. તાઈકવન્ડો એ ઝડપી અને ઊંચી લાત (કિક્સ) મારવા માટે જાણીતી માર્શલ આર્ટ છે.", "hi": "यह ताइक्वांडो है। ताइक्वांडो तेज़ और ऊँची लात (किक्स) मारने के लिए प्रसिद्ध मार्शल आर्ट है।"}'::jsonb, 
  '{"en": "Taekwondo comes from Korea. It teaches players speed, balance, and self-control. They wear a white uniform and head protectors during matches.", "gu": "તાઈકવન્ડો કોરિયાથી આવે છે. તે ખેલાડીઓને ઝડપ, સંતુલન અને આત્મ-નિયંત્રણ શીખવે છે. તેઓ મેચ દરમિયાન હેડ પ્રોટેક્ટર પહેરે છે.", "hi": "ताइक्वांडो कोरिया से आता है। यह खिलाड़ियों को गति, संतुलन और आत्म-नियंत्रण सिखाता है। वे मैच के दौरान सिर के रक्षक पहनते हैं।"}'::jsonb, 
  '{"en": "Did you know? The word ''Taekwondo'' means ''the way of the hand and foot''!", "gu": "શું તમે જાણો છો? ''તાઈકવન્ડો'' શબ્દનો અર્થ ''હાથ અને પગનો માર્ગ'' થાય છે!", "hi": "क्या आप जानते हैं? ''ताइक्वांडो'' शब्द का अर्थ ''हाथ और पैर का रास्ता'' होता है!"}'::jsonb, 
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

-- ITEM TENNIS
INSERT INTO public.sports 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'tennis', 
  (SELECT id FROM categories WHERE category_key = 'sports' LIMIT 1), 
  '{"en": "Tennis", "gu": "ટેનિસ", "hi": "टेनिस"}'::jsonb, 
  '/assets/images/sports/tennis.png', 
  '{"en": "This is Tennis. In tennis, we hit a yellow ball over a net on a court using rackets.", "gu": "આ ટેનિસ છે. ટેનિસમાં આપણે રેકેટ વડે નેટની ઉપરથી પીળી બોલને કોર્ટ પર હિટ કરીએ છીએ.", "hi": "यह टेनिस है। टेनिस में हम रैकेट से नेट के ऊपर से पीली गेंद को कोर्ट पर हिट करते हैं।"}'::jsonb, 
  '{"en": "Tennis can be played by two or four players. They run fast across the court to hit the bouncing ball back before it bounces twice.", "gu": "ટેનિસ બે કે ચાર ખેલાડીઓ રમી શકે છે. તેઓ બોલ બીજી વાર ટપ્પો ખાય તે પહેલાં તેને હિટ કરવા માટે કોર્ટ પર ઝડપથી દોડે છે.", "hi": "टेनिस दो या चार खिलाड़ी खेल सकते हैं। वे गेंद के दूसरी बार टप्पा खाने से पहले उसे हिट करने के लिए कोर्ट पर तेज़ी से दौड़ते हैं।"}'::jsonb, 
  '{"en": "Did you know? Originally, tennis was played with hands instead of rackets, which made people''s palms very sore!", "gu": "શું તમે જાણો છો? શરૂઆતમાં, ટેનિસ રેકેટને બદલે હાથથી રમવામાં આવતું હતું, જેનાથી હથેળીઓમાં ખૂબ દુખાવો થતો!", "hi": "क्या आप जानते हैं? शुरुआत में, टेनिस रैकेट के बजाय हाथों से खेला जाता था, जिससे लोगों की हथेलियों में बहुत दर्द होता था!"}'::jsonb, 
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

-- ITEM VOLLEYBALL
INSERT INTO public.sports 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'volleyball', 
  (SELECT id FROM categories WHERE category_key = 'sports' LIMIT 1), 
  '{"en": "Volleyball", "gu": "વોલીબોલ", "hi": "वॉलीबॉल"}'::jsonb, 
  '/assets/images/sports/volleyball.png', 
  '{"en": "This is Volleyball. In volleyball, teams hit a ball back and forth over a high net using hands.", "gu": "આ વોલીબોલ છે. વોલીબોલમાં ટીમો હાથનો ઉપયોગ કરીને ઊંચી નેટ પરથી બોલને આગળ-પાછળ હિટ કરે છે.", "hi": "यह वॉलीबॉल है। वॉलीबॉल में टीमें हाथ का उपयोग करके ऊंचे नेट के ऊपर से गेंद को आगे-पीछे हिट करती हैं।"}'::jsonb, 
  '{"en": "Six players on each side pass, set, and spike the ball. They try to make the ball land on the opponent''s side of the court to score.", "gu": "દરેક ટીમના છ ખેલાડીઓ બોલને પાસ અને સ્પાઇક કરે છે. તેઓ પોઇન્ટ મેળવવા માટે બોલને વિરોધી ટીમના મેદાનમાં પાડવાનો પ્રયાસ કરે છે.", "hi": "प्रत्येक टीम के छह खिलाड़ी गेंद को पास और स्पाइक करते हैं। वे अंक प्राप्त करने के लिए गेंद को विरोधी टीम के मैदान में गिराने का प्रयास करते हैं।"}'::jsonb, 
  '{"en": "Did you know? Volleyball was invented in 1895 as a less rough alternative to basketball!", "gu": "શું તમે જાણો છો? બાસ્કેટબોલના સરળ વિકલ્પ તરીકે ૧૮૯૫ માં વોલીબોલની શોધ કરવામાં આવી હતી!", "hi": "क्या आप जानते हैं? बास्केटबॉल के आसान विकल्प के रूप में 1895 में वॉलीबॉल का आविष्कार किया गया था!"}'::jsonb, 
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

-- ITEM WRESTLING
INSERT INTO public.sports 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'wrestling', 
  (SELECT id FROM categories WHERE category_key = 'sports' LIMIT 1), 
  '{"en": "Wrestling", "gu": "કુસ્તી", "hi": "कुश्ती"}'::jsonb, 
  '/assets/images/sports/wrestling.png', 
  '{"en": "This is Wrestling. Wrestling is a sport where two players grapple and try to pin each other''s shoulders to the mat.", "gu": "આ કુસ્તી છે. કુસ્તી એ એવી રમત છે જ્યાં બે ખેલાડીઓ એકબીજાને પકડે છે અને વિરોધીને મેટ પર પછાડવાનો પ્રયાસ કરે છે.", "hi": "यह कुश्ती है। कुश्ती ऐसा खेल है जहाँ दो खिलाड़ी एक-दूसरे को पकड़ते हैं और विरोधी को मैट पर गिराने का प्रयास करते हैं।"}'::jsonb, 
  '{"en": "Wrestlers use throws, holds, and leverage. They do not punch or kick. It requires great strength, balance, and quick reflexes.", "gu": "કુસ્તીબાજો પકડ અને દાવપેચનો ઉપયોગ કરે છે. તેઓ મુક્કા મારતા કે લાત મારતા નથી. તેમાં પુષ્કળ તાકાત અને સંતુલનની જરૂર હોય છે.", "hi": "कुश्तीबाज पकड़ और दांव-पेच का उपयोग करते हैं। वे मुक्के या लात नहीं मारते। इसमें बहुत ताकत और संतुलन की आवश्यकता होती है।"}'::jsonb, 
  '{"en": "Did you know? Wrestling is one of the oldest depicted sports in human history, found in cave drawings over 15,000 years old!", "gu": "શું તમે જાણો છો? કુસ્તી એ માનવ ઇતિહાસમાં સૌથી જૂની રમાતી રમતોમાંની એક છે, જે ૧૫,૦૦૦ વર્ષ જૂની ગુફાઓના ચિત્રોમાં પણ મળી આવી છે!", "hi": "क्या आप जानते हैं? कुश्ती मानव इतिहास के सबसे पुराने खेलों में से एक है, जो 15,000 साल पुराने गुफा चित्रों में भी मिला है!"}'::jsonb, 
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
