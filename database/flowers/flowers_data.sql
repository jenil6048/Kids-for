-- 1. Create flowers table and index
CREATE TABLE IF NOT EXISTS public.flowers (
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
  constraint flowers_pkey primary key (id),
  constraint flowers_topic_key_key unique (topic_key),
  constraint flowers_category_id_fkey foreign KEY (category_id) references categories (id) on delete CASCADE
) TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS idx_flowers_topic_key on public.flowers using btree (topic_key) TABLESPACE pg_default;

-- Disable Row Level Security (RLS) to fix private table access issues
ALTER TABLE public.flowers DISABLE ROW LEVEL SECURITY;

-- Grant permissions to anonymous client keys
GRANT ALL ON public.flowers TO anon;
GRANT ALL ON public.flowers TO authenticated;
GRANT ALL ON public.flowers TO service_role;

-- 2. Populate flowers table with 20 flowers data
-- Using matching as the primary game type

-- FLOWER BLUEBELL
INSERT INTO public.flowers 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'bluebell', 
  (SELECT id FROM categories WHERE category_key = 'flowers' LIMIT 1), 
  '{"en": "Bluebell", "gu": "બ્લુબેલ", "hi": "ब्लूबेल"}'::jsonb, 
  '/assets/images/flowers/bluebell.png', 
  '{"en": "This is a Bluebell. Bluebells look like little blue bells hanging on a stem.", "gu": "આ બ્લુબેલ છે. બ્લુબેલ ડાળી પર લટકતી નાની વાદળી ઘંટડીઓ જેવી લાગે છે.", "hi": "यह ब्लूबेल है। ब्लूबेल तने पर लटकी हुई छोटी नीली घंटियों जैसी दिखती है।"}'::jsonb, 
  '{"en": "Bluebells grow in beautiful forests. They bloom in spring and make the ground look like a blue carpet. Bees love bluebells.", "gu": "આ બ્લુબેલ સુંદર જંગલોમાં ઉગે છે. તેઓ વસંતઋતુમાં ખીલે છે અને જમીનને વાદળી ગાલીચા જેવી બનાવે છે. મધમાખીઓને બ્લુબેલ ગમે છે.", "hi": "ब्लूबेल सुंदर जंगलों में उगते हैं। वे वसंत ऋतु में खिलते हैं और ज़मीन को नीले कालीन जैसी बना देते हैं। मधुमक्खियों को ब्लूबेल बहुत पसंद हैं।"}'::jsonb, 
  '{"en": "Did you know? Bluebells get their name because they are shaped like real little bells!", "gu": "શું તમે જાણો છો? બ્લુબેલનું નામ એટલે પડ્યું કારણ કે તેનો આકાર નાની ઘંટડીઓ જેવો હોય છે!", "hi": "क्या आप जानते हैं? ब्लूबेल का नाम इसलिए पड़ा क्योंकि उनका आकार असली छोटी घंटियों जैसा होता है!"}'::jsonb, 
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

-- FLOWER CARNATION
INSERT INTO public.flowers 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'carnation', 
  (SELECT id FROM categories WHERE category_key = 'flowers' LIMIT 1), 
  '{"en": "Carnation", "gu": "કાર્નેશન", "hi": "कार्नेशन"}'::jsonb, 
  '/assets/images/flowers/carnation.png', 
  '{"en": "This is a Carnation. Carnations have fluffy petals that look like frills on a dress.", "gu": "આ કાર્નેશન છે. કાર્નેશનની પાંખડીઓ સુંદર અને ફ્રિલ જેવી દેખાય છે.", "hi": "यह कार्नेशन है। कार्नेशन की पंखुड़ियां बहुत सुंदर और झालरदार होती हैं।"}'::jsonb, 
  '{"en": "Carnations come in many colors like pink, red, and white. They stay fresh for a long time after being picked. People use them for decorations.", "gu": "કાર્નેશન ગુલાબી, લાલ અને સફેદ જેવા ઘણા રંગોમાં આવે છે. તોડ્યા પછી પણ તે લાંબો સમય તાજા રહે છે. લોકો તેનો ઉપયોગ સજાવટ માટે કરે છે.", "hi": "कार्नेशन गुलाबी, लाल और सफेद जैसे कई रंगों में आते हैं। तोड़े जाने के बाद भी वे लंबे समय तक ताजे रहते हैं। लोग इनका उपयोग सजावट के लिए करते हैं।"}'::jsonb, 
  '{"en": "Did you know? Carnations are often worn on Mother''s Day to show love!", "gu": "શું તમે જાણો છો? પ્રેમ દર્શાવવા માટે મધર્સ ડે પર ઘણીવાર કાર્નેશન પહેરવામાં આવે છે!", "hi": "क्या आप जानते हैं? प्यार जताने के लिए मदर्स डे पर अक्सर कार्नेशन पहने जाते हैं!"}'::jsonb, 
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

-- FLOWER CHERRY BLOSSOM
INSERT INTO public.flowers 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'cherry_blossom', 
  (SELECT id FROM categories WHERE category_key = 'flowers' LIMIT 1), 
  '{"en": "Cherry Blossom", "gu": "ચેરી બ્લોસમ", "hi": "चेरी ब्लॉसम"}'::jsonb, 
  '/assets/images/flowers/cherry_blossom.png', 
  '{"en": "This is a Cherry Blossom. Cherry blossoms are soft pink flowers that grow on tall trees.", "gu": "આ ચેરી બ્લોસમ છે. ચેરી બ્લોસમ એ ઊંચા ઝાડ પર ઉગતા નરમ ગુલાબી ફૂલો છે.", "hi": "यह चेरी ब्लॉसम है। चेरी ब्लॉसम ऊंचे पेड़ों पर उगने वाले हल्के गुलाबी रंग के फूल होते हैं।"}'::jsonb, 
  '{"en": "Cherry blossoms bloom for a short time in spring. When the wind blows, their petals dance in the air like pink snow. They are very famous in Japan.", "gu": "ચેરી બ્લોસમ વસંતઋતુમાં ટૂંકા સમય માટે ખીલે છે. જ્યારે પવન ફૂંકાય છે, ત્યારે તેમની પાંખડીઓ ગુલાબી બરફની જેમ હવામાં ઉડે છે. તેઓ જાપાનમાં ખૂબ જ પ્રખ્યાત છે.", "hi": "चेरी ब्लॉसम वसंत ऋतु में थोड़े समय के लिए खिलते हैं। जब हवा चलती है, तो उनकी पंखुड़ियां हवा में गुलाबी बर्फ की तरह उड़ती हैं। वे जापान में बहुत प्रसिद्ध हैं।"}'::jsonb, 
  '{"en": "Did you know? In Japan, families gather under cherry blossom trees for picnics called Hanami!", "gu": "શું તમે જાણો છો? જાપાનમાં, પરિવારો પિકનિક માટે ચેરી બ્લોસમના ઝાડ નીચે ભેગા થાય છે જેને ''હનામી'' કહેવાય છે!", "hi": "क्या आप जानते हैं? जापान में, परिवार पिकनिक मनाने के लिए चेरी ब्लॉसम के पेड़ों के नीचे इकट्ठा होते हैं जिसे ''हानामी'' कहा जाता है!"}'::jsonb, 
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

-- FLOWER DAFFODIL
INSERT INTO public.flowers 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'daffodil', 
  (SELECT id FROM categories WHERE category_key = 'flowers' LIMIT 1), 
  '{"en": "Daffodil", "gu": "ડેફોડિલ", "hi": "डैफ़ोडिल"}'::jsonb, 
  '/assets/images/flowers/daffodil.png', 
  '{"en": "This is a Daffodil. Daffodils are bright yellow flowers shaped like little trumpets.", "gu": "આ ડેફોડિલ છે. ડેફોડિલ એ પીળા રંગના ફૂલો છે જે નાની ટ્રમ્પેટ જેવા આકારના હોય છે.", "hi": "यह डैफ़ोडिल है। डैफ़ोडिल चमकीले पीले रंग के फूल होते हैं जिनका आकार छोटी तुरही जैसा होता है।"}'::jsonb, 
  '{"en": "Daffodils are one of the first flowers to wake up in spring. They show us that warm weather is coming. They love the sunshine.", "gu": "ડેફોડિલ વસંતઋતુમાં સૌથી પહેલા ખીલતા ફૂલોમાંના એક છે. તેઓ આપણને જણાવે છે કે ગરમીની ઋતુ આવી રહી છે. તેમને સૂર્યપ્રકાશ ગમે છે.", "hi": "डैफ़ोडिल वसंत ऋतु में सबसे पहले खिलने वाले फूलों में से एक हैं। वे हमें दिखाते हैं कि गर्मी का मौसम आ रहा है। उन्हें धूप बहुत पसंद है।"}'::jsonb, 
  '{"en": "Did you know? Daffodils represent new beginnings and happiness!", "gu": "શું તમે જાણો છો? ડેફોડિલ નવી શરૂઆત અને ખુશીનું પ્રતીક છે!", "hi": "क्या आप जानते हैं? डैफ़ोडिल नई शुरुआत और खुशियों का प्रतीक हैं!"}'::jsonb, 
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

-- FLOWER DAHLIA
INSERT INTO public.flowers 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'dahlia', 
  (SELECT id FROM categories WHERE category_key = 'flowers' LIMIT 1), 
  '{"en": "Dahlia", "gu": "ડાહલિયા", "hi": "डहेलिया"}'::jsonb, 
  '/assets/images/flowers/dahlia.png', 
  '{"en": "This is a Dahlia. Dahlias are big, round flowers with lots of neatly arranged petals.", "gu": "આ ડાહલિયા છે. ડાહલિયા એ મોટા, ગોળ ફૂલો છે જેમાં સુંદર રીતે ગોઠવાયેલી પાંખડીઓ હોય છે.", "hi": "यह डहेलिया है। डहेलिया बड़े, गोल फूल होते हैं जिनमें बहुत सारी व्यवस्थित पंखुड़ियां होती हैं।"}'::jsonb, 
  '{"en": "Dahlias bloom in summer and autumn. They come in almost every color you can think of. Gardeners love them because they are so colorful.", "gu": "ડાહલિયા ઉનાળા અને શરદઋતુમાં ખીલે છે. તમે વિચારી શકો તેવા લગભગ દરેક રંગમાં તે જોવા મળે છે. માળીઓને તે ખૂબ ગમે છે કારણ કે તે રંગબેરંગી હોય છે.", "hi": "डहेलिया गर्मियों और शरद ऋतु में खिलते हैं। ये लगभग हर उस रंग में आते हैं जो आप सोच सकते हैं। बागवानों को ये बहुत पसंद होते हैं क्योंकि ये बहुत रंगीन होते हैं।"}'::jsonb, 
  '{"en": "Did you know? Dahlia is the national flower of Mexico!", "gu": "શું તમે જાણો છો? ડાહલિયા એ મેક્સિકોનું રાષ્ટ્રીય ફૂલ છે!", "hi": "क्या आप जानते हैं? डहेलिया मेक्सिको का राष्ट्रीय फूल है!"}'::jsonb, 
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

-- FLOWER DAISY
INSERT INTO public.flowers 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'daisy', 
  (SELECT id FROM categories WHERE category_key = 'flowers' LIMIT 1), 
  '{"en": "Daisy", "gu": "ડેઇઝી", "hi": "डेज़ी"}'::jsonb, 
  '/assets/images/flowers/daisy.png', 
  '{"en": "This is a Daisy. Daisies have white petals and a bright yellow center like a little sun.", "gu": "આ ડેઇઝી છે. ડેઇઝીમાં સફેદ પાંખડીઓ અને નાના સૂર્ય જેવો તેજસ્વી પીળો મધ્ય ભાગ હોય છે.", "hi": "यह डेज़ी है। डेज़ी में सफेद पंखुड़ियां और एक चमकीला पीला केंद्र होता है जो छोटे सूरज जैसा दिखता है।"}'::jsonb, 
  '{"en": "Daisies grow in grassy fields. They close their petals at night and open them again in the morning. They look very simple and pretty.", "gu": "ડેઇઝી ઘાસવાળા મેદાનોમાં ઉગે છે. તેઓ રાત્રે તેમની પાંખડીઓ બંધ કરે છે અને સવારે ફરીથી ખોલે છે. તેઓ ખૂબ જ સાદા અને સુંદર દેખાય છે.", "hi": "डेज़ी घास के मैदानों में उगती है। वे रात में अपनी पंखुड़ियां बंद कर लेते हैं और सुबह फिर से खोल लेते हैं। वे बहुत सरल और सुंदर दिखते हैं।"}'::jsonb, 
  '{"en": "Did you know? Daisies are found on every continent except Antarctica!", "gu": "શું તમે જાણો છો? ડેઇઝી એન્ટાર્કટિકા સિવાય દરેક ખંડ પર જોવા મળે છે!", "hi": "क्या आप जानते हैं? डेज़ी अंटार्कटिका को छोड़कर हर महाद्वीप पर पाई जाती है!"}'::jsonb, 
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

-- FLOWER FORGET-ME-NOT
INSERT INTO public.flowers 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'forget_me_not', 
  (SELECT id FROM categories WHERE category_key = 'flowers' LIMIT 1), 
  '{"en": "Forget-me-not", "gu": "ફોર્ગેટ-મી-નોટ", "hi": "फ़ॉरगेट-मी-नॉट"}'::jsonb, 
  '/assets/images/flowers/forget_me_not.png', 
  '{"en": "This is a Forget-me-not. They are tiny, beautiful blue flowers with a yellow eye in the middle.", "gu": "આ ફોર્ગેટ-મી-નોટ છે. તેઓ વચ્ચે પીળો ભાગ ધરાવતા નાના, સુંદર વાદળી ફૂલો છે.", "hi": "यह फ़ॉरगेट-मी-नॉट है। ये छोटे, सुंदर नीले फूल होते हैं जिनके बीच में पीला भाग होता है।"}'::jsonb, 
  '{"en": "Forget-me-nots grow in groups. They symbolize true love and memories. People plant them to remember their loved ones.", "gu": "ફોર્ગેટ-મી-નોટ સમૂહમાં ઉગે છે. તેઓ સાચા પ્રેમ અને યાદોનું પ્રતીક છે. લોકો તેમના પ્રિયજનોને યાદ કરવા માટે તેને વાવે છે.", "hi": "फ़ॉरगेट-मी-नॉट समूहों में उगते हैं। वे सच्चे प्यार और यादों का प्रतीक हैं। लोग अपने प्रियजनों को याद रखने के लिए इन्हें लगाते हैं।"}'::jsonb, 
  '{"en": "Did you know? According to a legend, whoever wears this flower will never be forgotten by their friends!", "gu": "શું તમે જાણો છો? એક દંતકથા અનુસાર, જે કોઈ આ ફૂલ પહેરે છે તેને તેના મિત્રો ક્યારેય ભૂલી શકતા નથી!", "hi": "क्या आप जानते हैं? एक पौराणिक कथा के अनुसार, जो कोई भी इस फूल को पहनता है उसे उसके दोस्त कभी नहीं भूलते!"}'::jsonb, 
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

-- FLOWER FOXGLOVE
INSERT INTO public.flowers 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'foxglove', 
  (SELECT id FROM categories WHERE category_key = 'flowers' LIMIT 1), 
  '{"en": "Foxglove", "gu": "ફોક્સગ્લોવ", "hi": "फॉक्सग्लोव"}'::jsonb, 
  '/assets/images/flowers/foxglove.png', 
  '{"en": "This is a Foxglove. Foxgloves have tall spikes loaded with bell-shaped flowers.", "gu": "આ ફોક્સગ્લોવ છે. ફોક્સગ્લોવમાં લાંબી ડાળીઓ પર ઘંટડી આકારના ઘણા ફૂલો હોય છે.", "hi": "यह फॉक्सग्लोव है। फॉक्सग्लोव में लंबे तने पर लटके हुए बहुत से घंटी के आकार के फूल होते हैं।"}'::jsonb, 
  '{"en": "Foxgloves can grow taller than a human! Their flowers have spots inside that help bees find sweet nectar. They grow in wild gardens.", "gu": "ફોક્સગ્લોવ માણસ કરતાં પણ ઉંચા વધી શકે છે! તેમના ફૂલોની અંદર ટપકાં હોય છે જે મધમાખીઓને મધ શોધવામાં મદદ કરે છે. તેઓ બગીચાઓમાં ઉગે છે.", "hi": "फॉक्सग्लोव एक इंसान से भी लंबे हो सकते हैं! उनके फूलों के अंदर धब्बे होते हैं जो मधुमक्खियों को मीठा रस खोजने में मदद करते हैं। वे जंगली बगीचों में उगते हैं।"}'::jsonb, 
  '{"en": "Did you know? Old stories say that fairies used to wear these flowers as gloves on their hands!", "gu": "શું તમે જાણો છો? જૂની વાર્તાઓ કહે છે કે પરીઓ આ ફૂલોનો ઉપયોગ હાથના મોજા (gloves) તરીકે કરતી હતી!", "hi": "क्या आप जानते हैं? पुरानी कहानियों के अनुसार परियाँ इन फूलों को अपने हाथों में दस्ताने के रूप में पहनती थीं!"}'::jsonb, 
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

-- FLOWER HIBISCUS
INSERT INTO public.flowers 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'hibiscus', 
  (SELECT id FROM categories WHERE category_key = 'flowers' LIMIT 1), 
  '{"en": "Hibiscus", "gu": "જાસૂદ", "hi": "गुड़हल"}'::jsonb, 
  '/assets/images/flowers/hibiscus.png', 
  '{"en": "This is a Hibiscus. Hibiscus flowers are large and showy with a long stem popping out of the center.", "gu": "આ જાસૂદ છે. જાસૂદના ફૂલો મોટા અને સુંદર હોય છે જેની વચ્ચેથી એક લાંબી નળી જેવો ભાગ બહાર નીકળે છે.", "hi": "यह गुड़हल है। गुड़हल के फूल बड़े और सुंदर होते हैं जिनके केंद्र से एक लंबा तंतु बाहर निकला होता है।"}'::jsonb, 
  '{"en": "Hibiscus flowers love warm, tropical places. Hummingbirds and butterflies love to visit them. Many people make tea from hibiscus flowers.", "gu": "જાસૂદને ગરમ અને ભેજવાળી જગ્યાઓ ગમે છે. હમિંગબર્ડ અને પતંગિયાને જાસૂદ પર બેસવું ગમે છે. ઘણા લોકો જાસૂદના ફૂલોમાંથી ચા બનાવે છે.", "hi": "गुड़हल को गर्म स्थान बहुत पसंद होते हैं। हमिंगबर्ड और तितलियाँ गुड़हल पर आना पसंद करती हैं। कई लोग गुड़हल के फूलों से चाय भी बनाते हैं।"}'::jsonb, 
  '{"en": "Did you know? In some places, wearing a hibiscus flower behind your ear shows if you are looking for a friend!", "gu": "શું તમે જાણો છો? કેટલીક જગ્યાએ કાનની પાછળ જાસૂદનું ફૂલ પહેરવાથી ખબર પડે છે કે તમે મિત્ર શોધી રહ્યા છો!", "hi": "क्या आप जानते हैं? कुछ जगहों पर कान के पीछे गुड़हल का फूल पहनना यह दर्शाता है कि आप एक दोस्त की तलाश में हैं!"}'::jsonb, 
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

-- FLOWER IRIS
INSERT INTO public.flowers 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'iris', 
  (SELECT id FROM categories WHERE category_key = 'flowers' LIMIT 1), 
  '{"en": "Iris", "gu": "આઇરિસ", "hi": "आइरिस"}'::jsonb, 
  '/assets/images/flowers/iris.png', 
  '{"en": "This is an Iris. Iris flowers have unique petals that look like butterfly wings.", "gu": "આ આઇરિસ છે. આઇરિસના ફૂલોમાં વિશિષ્ટ પાંખડીઓ હોય છે જે પતંગિયાની પાંખો જેવી લાગે છે.", "hi": "यह आइरिस है। आइरिस के फूलों में अनोखी पंखुड़ियां होती हैं जो तितली के पंखों जैसी दिखती हैं।"}'::jsonb, 
  '{"en": "Iris flowers come in many deep colors like purple and blue. The word Iris means rainbow in Greek. They grow in gardens and near water.", "gu": "આઇરિસ જાંબલી અને વાદળી જેવા ઘેરા રંગોમાં આવે છે. ગ્રીક ભાષામાં આઇરિસ શબ્દનો અર્થ મેઘધનુષ થાય છે. તેઓ બગીચાઓમાં અને પાણીની નજીક ઉગે છે.", "hi": "आइरिस बैंगनी और नीले जैसे गहरे रंगों में आते हैं। ग्रीक भाषा में आइरिस शब्द का अर्थ इंद्रधनुष होता है। ये बगीचों में और पानी के पास उगते हैं।"}'::jsonb, 
  '{"en": "Did you know? The Iris flower is named after Iris, the Greek goddess of the rainbow!", "gu": "શું તમે જાણો છો? આઇરિસ ફૂલનું નામ મેઘધનુષની ગ્રીક દેવી આઇરિસ પરથી રાખવામાં આવ્યું છે!", "hi": "क्या आप जानते हैं? आइरिस फूल का नाम इंद्रधनुष की ग्रीक देवी आइरिस के नाम पर रखा गया है!"}'::jsonb, 
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

-- FLOWER LAVENDER
INSERT INTO public.flowers 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'lavender', 
  (SELECT id FROM categories WHERE category_key = 'flowers' LIMIT 1), 
  '{"en": "Lavender", "gu": "લેવેન્ડર", "hi": "लैवेंडर"}'::jsonb, 
  '/assets/images/flowers/lavender.png', 
  '{"en": "This is Lavender. Lavender grows in tall, purple spikes and has a wonderful, relaxing scent.", "gu": "આ લેવેન્ડર છે. લેવેન્ડર લાંબી, જાંબલી ડાળીઓ પર ઉગે છે અને તેની સુગંધ ખૂબ જ સુંદર અને શાંતિ આપનારી હોય છે.", "hi": "यह लैवेंडर है। लैवेंडर लंबी, बैंगनी रंग की डालियों पर उगता है और इसकी खुशबू बहुत ही सुखद और शांत करने वाली होती है।"}'::jsonb, 
  '{"en": "Lavender loves hot sun and dry soil. Its sweet smell helps people relax and sleep better. People make oils and soaps from lavender.", "gu": "લેવેન્ડરને ગરમ તડકો અને સૂકી જમીન ગમે છે. તેની મીઠી સુગંધ લોકોને તણાવમુક્ત રહેવા અને સારી ઊંઘ લેવામાં મદદ કરે છે. લોકો લેવેન્ડરમાંથી તેલ અને સાબુ બનાવે છે.", "hi": "लैवेंडर को तेज़ धूप और सूखी मिट्टी पसंद है। इसकी मीठी खुशबू लोगों को शांत होने और बेहतर सोने में मदद करती है। लोग लैवेंडर से तेल और साबुन बनाते हैं।"}'::jsonb, 
  '{"en": "Did you know? Bees absolutely love lavender, and it helps them make delicious honey!", "gu": "શું તમે જાણો છો? મધમાખીઓને લેવેન્ડર ખૂબ જ ગમે છે, અને તે તેમને સ્વાદિષ્ટ મધ બનાવવામાં મદદ કરે છે!", "hi": "क्या आप जानते हैं? मधुमक्खियों को लैवेंडर बहुत पसंद होता है, और यह उन्हें स्वादिष्ट शहद बनाने में मदद करता है!"}'::jsonb, 
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

-- FLOWER LILY
INSERT INTO public.flowers 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'lily', 
  (SELECT id FROM categories WHERE category_key = 'flowers' LIMIT 1), 
  '{"en": "Lily", "gu": "લીલી", "hi": "लिली"}'::jsonb, 
  '/assets/images/flowers/lily.png', 
  '{"en": "This is a Lily. Lilies are large, elegant flowers with long petals shaped like stars.", "gu": "આ લીલી છે. લીલી એ તારા આકારની લાંબી પાંખડીઓ ધરાવતું એક મોટું અને આકર્ષક ફૂલ છે.", "hi": "यह लिली है। लिली तारे के आकार की लंबी पंखुड़ियों वाला एक बड़ा और सुंदर फूल है।"}'::jsonb, 
  '{"en": "Lilies smell very sweet and grow from bulbs. They can be white, pink, or orange. Many lilies have spots on their petals.", "gu": "લીલીની સુગંધ ખૂબ જ મીઠી હોય છે અને તે કંદમાંથી ઉગે છે. તે સફેદ, ગુલાબી અથવા નારંગી હોઈ શકે છે. ઘણી લીલીની પાંખડીઓ પર ટપકાં હોય છે.", "hi": "लिली की खुशबू बहुत मीठी होती है और ये कंद से उगते हैं। ये सफेद, गुलाबी या नारंगी हो सकते हैं। कई लिली की पंखुड़ियों पर धब्बे होते हैं।"}'::jsonb, 
  '{"en": "Did you know? Some lilies can grow floating on water, and they are called water lilies!", "gu": "શું તમે જાણો છો? કેટલીક લીલી પાણી પર તરતી રહી શકે છે, અને તેને વોટર લીલી (પોચું) કહેવાય છે!", "hi": "क्या आप जानते हैं? कुछ लिली पानी पर तैरते हुए उग सकती हैं, और उन्हें वाटर लिली (कुमुदिनी) कहा जाता है!"}'::jsonb, 
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

-- FLOWER LOTUS
INSERT INTO public.flowers 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'lotus', 
  (SELECT id FROM categories WHERE category_key = 'flowers' LIMIT 1), 
  '{"en": "Lotus", "gu": "કમળ", "hi": "कमल"}'::jsonb, 
  '/assets/images/flowers/lotus.png', 
  '{"en": "This is a Lotus. The lotus is a beautiful flower that floats on top of muddy ponds.", "gu": "આ કમળ છે. કમળ એ એક સુંદર ફૂલ છે જે કાદવવાળા તળાવમાં પાણીની સપાટી પર તરે છે.", "hi": "यह कमल है। कमल एक सुंदर फूल है जो कीचड़ भरे तालाबों में पानी की सतह पर तैरता है।"}'::jsonb, 
  '{"en": "The lotus opens its petals with the morning sun and closes them at night. Its leaves are waterproof, so water drops slide right off. It is a symbol of purity.", "gu": "કમળ સવારના સૂર્ય સાથે તેની પાંખડીઓ ખોલે છે અને રાત્રે બંધ કરે છે. તેના પાંદડા વોટરપ્રૂફ હોય છે, જેથી પાણીના ટીપાં તેના પરથી સરકી જાય છે. તે પવિત્રતાનું પ્રતીક છે.", "hi": "कमल सुबह के सूरज के साथ अपनी पंखुड़ियाँ खोलता है और रात में बंद कर देता है। इसके पत्ते वाटरप्रूफ होते हैं, जिससे पानी की बूंदें उन पर से फिसल जाती हैं। यह पवित्रता का प्रतीक है।"}'::jsonb, 
  '{"en": "Did you know? The lotus is the national flower of India!", "gu": "શું તમે જાણો છો? કમળ એ ભારતનું રાષ્ટ્રીય ફૂલ છે!", "hi": "क्या आप जानते हैं? कमल भारत का राष्ट्रीय फूल है!"}'::jsonb, 
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

-- FLOWER MARIGOLD
INSERT INTO public.flowers 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'marigold', 
  (SELECT id FROM categories WHERE category_key = 'flowers' LIMIT 1), 
  '{"en": "Marigold", "gu": "ગલગોટો", "hi": "गेंदा"}'::jsonb, 
  '/assets/images/flowers/marigold.png', 
  '{"en": "This is a Marigold. Marigolds are bright orange and yellow flowers that look like warm little suns.", "gu": "આ ગલગોટો છે. ગલગોટો એ તેજસ્વી નારંગી અને પીળા રંગના ફૂલો છે જે નાના ગરમ સૂર્ય જેવા દેખાય છે.", "hi": "यह गेंदा है। गेंदा चमकीले नारंगी और पीले रंग के फूल होते हैं जो छोटे गर्म सूरज जैसे दिखते हैं।"}'::jsonb, 
  '{"en": "Marigolds grow very easily in gardens. They have a strong smell that keeps pests away from vegetables. People use them to make festive garlands.", "gu": "ગલગોટો બગીચામાં ખૂબ જ સરળતાથી ઉગે છે. તેની તીવ્ર ગંધ શાકભાજીથી જંતુઓને દૂર રાખે છે. લોકો તેનો ઉપયોગ તહેવારોમાં હાર બનાવવા માટે કરે છે.", "hi": "गेंदा बगीचों में बहुत आसानी से उगता है। इसकी तेज़ गंध कीड़ों को सब्जियों से दूर रखती है। लोग त्योहारों में माला बनाने के लिए इनका उपयोग करते हैं।"}'::jsonb, 
  '{"en": "Did you know? Marigolds are called ''herbs of the sun'' because they open when the sun shines!", "gu": "શું તમે જાણો છો? ગલગોટાને ''સૂર્યની વનસ્પતિ'' કહેવામાં આવે છે કારણ કે જ્યારે સૂર્ય ચમકે ત્યારે જ તે ખીલે છે!", "hi": "क्या आप जानते हैं? गेंदे को ''सूरज की जड़ी-बूटी'' कहा जाता है क्योंकि वे तभी खिलते हैं जब सूरज चमकता है!"}'::jsonb, 
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

-- FLOWER ORCHID
INSERT INTO public.flowers 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'orchid', 
  (SELECT id FROM categories WHERE category_key = 'flowers' LIMIT 1), 
  '{"en": "Orchid", "gu": "ઓર્કિડ", "hi": "ऑर्किड"}'::jsonb, 
  '/assets/images/flowers/orchid.png', 
  '{"en": "This is an Orchid. Orchids are exotic and colorful flowers that come in amazing shapes.", "gu": "આ ઓર્કિડ છે. ઓર્કિડ એ અદ્ભુત આકારો ધરાવતા રંગબેરંગી અને સુંદર ફૂલો છે.", "hi": "यह ऑर्किड है। ऑर्किड बहुत ही सुंदर और रंग-बिरंगे फूल होते हैं जो अनोखे आकारों में आते हैं।"}'::jsonb, 
  '{"en": "Orchids can grow on trees instead of soil. They take water and nutrients from the air around them. They are very delicate and special.", "gu": "ઓર્કિડ માટીના બદલે ઝાડ પર ઉગી શકે છે. તેઓ તેમની આસપાસની હવામાંથી પાણી અને પોષક તત્વો મેળવે છે. તેઓ ખૂબ જ નાજુક અને ખાસ હોય છે.", "hi": "ऑर्किड मिट्टी के बजाय पेड़ों पर उग सकते हैं। वे अपने आस-पास की हवा से पानी और पोषक तत्व लेते हैं। वे बहुत नाजुक और विशेष होते हैं।"}'::jsonb, 
  '{"en": "Did you know? The vanilla flavor we love in ice cream comes from a special type of orchid plant!", "gu": "શું તમે જાણો છો? આઈસ્ક્રીમમાં આપણને ગમતો વેનીલા સ્વાદ એક ખાસ પ્રકારના ઓર્કિડ છોડમાંથી આવે છે!", "hi": "क्या आप जानते हैं? आइसक्रीम में जो वैनिला स्वाद हमें पसंद है, वह एक विशेष प्रकार के ऑर्किड पौधे से आता है!"}'::jsonb, 
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

-- FLOWER PANSY
INSERT INTO public.flowers 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'pansy', 
  (SELECT id FROM categories WHERE category_key = 'flowers' LIMIT 1), 
  '{"en": "Pansy", "gu": "પેન્સી", "hi": "पैंज़ी"}'::jsonb, 
  '/assets/images/flowers/pansy.png', 
  '{"en": "This is a Pansy. Pansies have overlapping petals that look like they have a little face on them.", "gu": "આ પેન્સી છે. પેન્સીમાં એકબીજા પર ચઢેલી પાંખડીઓ હોય છે જે નાનકડા ચહેરા જેવી દેખાય છે.", "hi": "यह पैंज़ी है। पैंज़ी में एक-दूसरे के ऊपर चढ़ी हुई पंखुड़ियां होती हैं जो छोटे चेहरे जैसी दिखती हैं।"}'::jsonb, 
  '{"en": "Pansies are tough flowers that love cool weather. They come in bright combinations of purple, yellow, and blue. They look very happy in garden borders.", "gu": "પેન્સી ઠંડી ઋતુના મજબૂત ફૂલો છે. તેઓ જાંબલી, પીળા અને વાદળી રંગના સુંદર સંયોજનોમાં જોવા મળે છે. બગીચાની બોર્ડર પર તેઓ સુંદર લાગે છે.", "hi": "पैंज़ी ठंडे मौसम के मजबूत फूल हैं। वे बैंगनी, पीले और नीले रंग के सुंदर संयोजनों में आते हैं। बगीचे की क्यारियों में वे बहुत सुंदर लगते हैं।"}'::jsonb, 
  '{"en": "Did you know? The name pansy comes from the French word ''pensée'', which means thought!", "gu": "શું તમે જાણો છો? પેન્સી નામ ફ્રેન્ચ શબ્દ ''pensée'' પરથી આવ્યું છે, જેનો અર્થ વિચાર થાય છે!", "hi": "क्या आप जानते हैं? पैंज़ी नाम फ्रेंच शब्द ''pensée'' से आया है, जिसका अर्थ विचार होता है!"}'::jsonb, 
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

-- FLOWER POPPY
INSERT INTO public.flowers 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'poppy', 
  (SELECT id FROM categories WHERE category_key = 'flowers' LIMIT 1), 
  '{"en": "Poppy", "gu": "પોપી", "hi": "पोपी"}'::jsonb, 
  '/assets/images/flowers/poppy.png', 
  '{"en": "This is a Poppy. Poppies are bright red flowers with a dark, fuzzy center.", "gu": "આ પોપી છે. પોપી એ ઘેરો મધ્ય ભાગ ધરાવતા તેજસ્વી લાલ રંગના ફૂલો છે.", "hi": "यह पोपी है। पोपी चमकीले लाल रंग के फूल होते हैं जिनका केंद्र गहरा होता है।"}'::jsonb, 
  '{"en": "Poppies have very thin petals that look like tissue paper. They grow in wild fields. Many people wear poppies to remember brave soldiers.", "gu": "પોપીની પાંખડીઓ ખૂબ જ પાતળી હોય છે જે ટીશ્યુ પેપર જેવી દેખાય છે. તેઓ જંગલી મેદાનોમાં ઉગે છે. બહાદુર સૈનિકોને યાદ કરવા માટે ઘણા લોકો પોપી પહેરે છે.", "hi": "पोपी की पंखुड़ियां बहुत पतली होती हैं जो टिशू पेपर जैसी दिखती हैं। वे जंगली मैदानों में उगते हैं। बहादुर सैनिकों को याद करने के लिए कई लोग पोपी पहनते हैं।"}'::jsonb, 
  '{"en": "Did you know? Poppy seeds are used on top of delicious breads and bagels!", "gu": "શું તમે જાણો છો? પોપીના બીજ (ખસખસ) નો ઉપયોગ સ્વાદિષ્ટ બ્રેડ અને બેગલ્સ પર થાય છે!", "hi": "क्या आप जानते हैं? पोपी के बीजों (खसखस) का उपयोग स्वादिष्ट ब्रेड और बन के ऊपर किया जाता है!"}'::jsonb, 
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

-- FLOWER ROSE
INSERT INTO public.flowers 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'rose', 
  (SELECT id FROM categories WHERE category_key = 'flowers' LIMIT 1), 
  '{"en": "Rose", "gu": "ગુલાબ", "hi": "गुलाब"}'::jsonb, 
  '/assets/images/flowers/rose.png', 
  '{"en": "This is a Rose. Roses are beautiful flowers with lovely, overlapping petals.", "gu": "આ ગુલાબ છે. ગુલાબ એ સુંદર, એકબીજા પર ચઢેલી પાંખડીઓ ધરાવતું આકર્ષક ફૂલ છે.", "hi": "यह गुलाब है। गुलाब सुंदर, एक-दूसरे के ऊपर चढ़ी हुई पंखुड़ियों वाला एक आकर्षक फूल है।"}'::jsonb, 
  '{"en": "Roses grow on bushes and have sharp thorns on their stems to protect themselves. They smell wonderful and come in many colors. Many people give roses to show love.", "gu": "ગુલાબ છોડ પર ઉગે છે અને પોતાનું રક્ષણ કરવા માટે તેમની ડાળી પર તીક્ષ્ણ કાંટા હોય છે. તેમની સુગંધ અદ્ભુત હોય છે અને તે ઘણા રંગોમાં આવે છે. લોકો પ્રેમ દર્શાવવા ગુલાબ આપે છે.", "hi": "गुलाब झाड़ियों पर उगते हैं और अपनी रक्षा के लिए उनके तनों पर तीखे कांटे होते हैं। इनकी खुशबू बहुत अच्छी होती है और ये कई रंगों में आते हैं। लोग प्यार जताने के लिए गुलाब देते हैं।"}'::jsonb, 
  '{"en": "Did you know? Red roses are a classic symbol of love and friendship around the world!", "gu": "શું તમે જાણો છો? લાલ ગુલાબ એ વિશ્વભરમાં પ્રેમ અને મિત્રતાનું જાણીતું પ્રતીક છે!", "hi": "क्या आप जानते हैं? लाल गुलाब दुनिया भर में प्यार और दोस्ती का एक जाना-माना प्रतीक है!"}'::jsonb, 
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

-- FLOWER SUNFLOWER
INSERT INTO public.flowers 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'sunflower', 
  (SELECT id FROM categories WHERE category_key = 'flowers' LIMIT 1), 
  '{"en": "Sunflower", "gu": "સૂર્યમુખી", "hi": "सूरजमुखी"}'::jsonb, 
  '/assets/images/flowers/sunflower.png', 
  '{"en": "This is a Sunflower. Sunflowers are giant, happy yellow flowers that track the sun.", "gu": "આ સૂર્યમુખી છે. સૂર્યમુખી એ વિશાળ, પીળા રંગના ફૂલો છે જે સૂર્યની દિશામાં ફરે છે.", "hi": "यह सूरजमुखी है। सूरजमुखी विशाल, चमकीले पीले रंग के फूल होते हैं जो सूरज की दिशा में घूमते हैं।"}'::jsonb, 
  '{"en": "Sunflowers can grow taller than houses! They turn their faces to follow the sun across the sky. They have lots of seeds in the center that birds love to eat.", "gu": "સૂર્યમુખી ઘર કરતાં પણ ઊંચા વધી શકે છે! તેઓ આકાશમાં સૂર્યને અનુસરવા માટે પોતાનો ચહેરો ફેરવે છે. તેમના મધ્ય ભાગમાં ઘણા બધા બીજ હોય છે જે પક્ષીઓને ખાવા ગમે છે.", "hi": "सूरजमुखी घर से भी ऊंचे हो सकते हैं! वे आसमान में सूरज के पीछे-पीछे अपना चेहरा घुमाते हैं। इनके केंद्र में बहुत सारे बीज होते हैं जिन्हें पक्षी खाना पसंद करते हैं।"}'::jsonb, 
  '{"en": "Did you know? The center of a giant sunflower is actually made of thousands of tiny flowers growing together!", "gu": "શું તમે જાણો છો? વિશાળ સૂર્યમુખીનો મધ્ય ભાગ ખરેખર હજારો નાના ફૂલોથી બનેલો હોય છે જે સાથે ઉગે છે!", "hi": "क्या आप जानते हैं? एक विशाल सूरजमुखी का केंद्र वास्तव में एक साथ उगने वाले हजारों छोटे फूलों से बना होता है!"}'::jsonb, 
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

-- FLOWER TULIP
INSERT INTO public.flowers 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'tulip', 
  (SELECT id FROM categories WHERE category_key = 'flowers' LIMIT 1), 
  '{"en": "Tulip", "gu": "ટ્યૂલિપ", "hi": "ट्यूलिप"}'::jsonb, 
  '/assets/images/flowers/tulip.png', 
  '{"en": "This is a Tulip. Tulips are cup-shaped flowers that look like colorful little bowls.", "gu": "આ ટ્યૂલિપ છે. ટ્યૂલિપ એ પ્યાલા આકારના ફૂલો છે જે રંગબેરંગી નાની વાટકીઓ જેવા લાગે છે.", "hi": "यह ट्यूलिप है। ट्यूलिप कप के आकार के फूल होते हैं जो रंग-बिरंगी छोटी कटोरी जैसे दिखते हैं।"}'::jsonb, 
  '{"en": "Tulips bloom in spring and look very neat and smooth. They come in bright colors like red, yellow, and purple. They grow from flower bulbs.", "gu": "ટ્યૂલિપ વસંતઋતુમાં ખીલે છે અને ખૂબ જ સુંદર અને સીધા દેખાય છે. તેઓ લાલ, પીળા અને જાંબલી જેવા તેજસ્વી રંગોમાં આવે છે. તેઓ ફૂલના કંદમાંથી ઉગે છે.", "hi": "ट्यूलिप वसंत ऋतु में खिलते हैं और बहुत ही सुंदर और सीधे दिखते हैं। वे लाल, पीले और बैंगनी जैसे चमकीले रंगों में आते हैं। वे फूलों के कंद से उगते हैं।"}'::jsonb, 
  '{"en": "Did you know? Tulip petals are actually edible and can be used in salads instead of onions!", "gu": "શું તમે જાણો છો? ટ્યૂલિપની પાંખડીઓ ખાદ્ય હોય છે અને ડુંગળીને બદલે કચુંબરમાં વાપરી શકાય છે!", "hi": "क्या आप जानते हैं? ट्यूलिप की पंखुड़ियाँ वास्तव में खाने योग्य होती हैं और प्याज के बजाय सलाद में इस्तेमाल की जा सकती हैं!"}'::jsonb, 
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
