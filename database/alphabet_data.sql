-- 1. Update cover image paths in categories table
UPDATE categories
SET image_path =
CASE category_key
    WHEN 'alphabet' THEN 'https://pdhqylmzjdkvdbnezwhq.supabase.co/storage/v1/object/public/assets/covers/alphabet.png'
    WHEN 'colors' THEN 'https://pdhqylmzjdkvdbnezwhq.supabase.co/storage/v1/object/public/assets/covers/color.png'
    WHEN 'numbers' THEN 'https://pdhqylmzjdkvdbnezwhq.supabase.co/storage/v1/object/public/assets/covers/numbers.png'
    WHEN 'shapes' THEN 'https://pdhqylmzjdkvdbnezwhq.supabase.co/storage/v1/object/public/assets/covers/shapes.png'
    WHEN 'animals' THEN 'https://pdhqylmzjdkvdbnezwhq.supabase.co/storage/v1/object/public/assets/covers/animals.png'
    WHEN 'sports' THEN 'https://pdhqylmzjdkvdbnezwhq.supabase.co/storage/v1/object/public/assets/covers/sports.png'
    WHEN 'vehicles' THEN 'https://pdhqylmzjdkvdbnezwhq.supabase.co/storage/v1/object/public/assets/covers/vehicles.png'
    WHEN 'space' THEN 'https://pdhqylmzjdkvdbnezwhq.supabase.co/storage/v1/object/public/assets/covers/space.png'
    WHEN 'countries' THEN 'https://pdhqylmzjdkvdbnezwhq.supabase.co/storage/v1/object/public/assets/covers/countries.png'
    WHEN 'science' THEN 'https://pdhqylmzjdkvdbnezwhq.supabase.co/storage/v1/object/public/assets/covers/science.png'
END
WHERE category_key IN (
    'alphabet',
    'colors',
    'numbers',
    'shapes',
    'animals',
    'sports',
    'vehicles',
    'space',
    'countries',
    'science'
);


-- 2. Create alphabet table and index
CREATE TABLE IF NOT EXISTS public.alphabet (
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
  constraint alphabet_pkey primary key (id),
  constraint alphabet_topic_key_key unique (topic_key),
  constraint alphabet_category_id_fkey foreign KEY (category_id) references categories (id) on delete CASCADE
) TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS idx_alphabet_topic_key on public.alphabet using btree (topic_key) TABLESPACE pg_default;

-- Disable Row Level Security (RLS) to fix private table access issues
ALTER TABLE public.alphabet DISABLE ROW LEVEL SECURITY;

-- Grant permissions to anonymous client keys
GRANT ALL ON public.alphabet TO anon;
GRANT ALL ON public.alphabet TO authenticated;
GRANT ALL ON public.alphabet TO service_role;


-- 3. Populate alphabet table with 26 letters data

INSERT INTO public.alphabet 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'a', 
  (SELECT id FROM categories WHERE category_key = 'alphabet' OR category_key = 'abc_alphabets' LIMIT 1), 
  '{"en": "A", "gu": "A", "hi": "A"}'::jsonb, 
  'https://pdhqylmzjdkvdbnezwhq.supabase.co/storage/v1/object/public/assets/alphabets/a.svg', 
  '{"en": "A is for Apple! Apples are sweet and crunchy fruits.", "gu": "એ એટલે એપલ! સફરજન મીઠા અને ક્રન્ચી ફળ છે.", "hi": "ए से एप्पल! सेब मीठे और कुरकुरे फल होते हैं।"}'::jsonb, 
  '{"en": "Apples grow on trees and can be red, green, or yellow! They are very healthy for you.", "gu": "સફરજન ઝાડ પર ઉગે છે અને તે લાલ, લીલા કે પીળા હોઈ શકે છે! તે તમારા સ્વાસ્થ્ય માટે ખૂબ સારા છે.", "hi": "सेब पेड़ों पर उगते हैं और लाल, हरे या पीले हो सकते हैं! वे आपके स्वास्थ्य के लिए बहुत अच्छे हैं।"}'::jsonb, 
  '{"en": "Did you know? An apple tree can live for more than 100 years!", "gu": "શું તમે જાણો છો? સફરજનનું ઝાડ ૧૦૦ વર્ષથી વધુ જીવી શકે છે!", "hi": "क्या आपको पता है? सेब का पेड़ 100 साल से अधिक समय तक जीवित रह सकता है!"}'::jsonb, 
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

INSERT INTO public.alphabet 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'b', 
  (SELECT id FROM categories WHERE category_key = 'alphabet' OR category_key = 'abc_alphabets' LIMIT 1), 
  '{"en": "B", "gu": "B", "hi": "B"}'::jsonb, 
  'https://pdhqylmzjdkvdbnezwhq.supabase.co/storage/v1/object/public/assets/alphabets/b.svg', 
  '{"en": "B is for Ball! Balls are round and fun to bounce and play with.", "gu": "બી એટલે બોલ! દડા ગોળ હોય છે અને ઉછળવા અને રમવા માટે મજાના હોય છે.", "hi": "बी से बॉल! गेंदें गोल होती हैं और उछालने और खेलने में मजेदार होती हैं।"}'::jsonb, 
  '{"en": "We use balls to play games like soccer, basketball, and tennis with our friends!", "gu": "આપણે મિત્રો સાથે ફૂટબોલ, બાસ્કેટબોલ અને ટેનિસ જેવી રમતો રમવા માટે દડાનો ઉપયોગ કરીએ છીએ!", "hi": "हम अपने दोस्तों के साथ फुटबॉल, बास्केटबॉल और टेनिस जैसे खेल खेलने के लिए गेंदों का उपयोग करते हैं!"}'::jsonb, 
  '{"en": "Did you know? The oldest game played with a ball was invented over 3,000 years ago!", "gu": "શું તમે જાણો છો? દડા સાથે રમાતી સૌથી જૂની રમત ૩,૦૦૦ વર્ષ પહેલાં શોધાઈ હતી!", "hi": "क्या आपको पता है? गेंद से खेला जाने वाला सबसे पुराना खेल 3,000 साल से भी पहले आविष्कृत हुआ था!"}'::jsonb, 
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

INSERT INTO public.alphabet 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'c', 
  (SELECT id FROM categories WHERE category_key = 'alphabet' OR category_key = 'abc_alphabets' LIMIT 1), 
  '{"en": "C", "gu": "C", "hi": "C"}'::jsonb, 
  'https://pdhqylmzjdkvdbnezwhq.supabase.co/storage/v1/object/public/assets/alphabets/c.svg', 
  '{"en": "C is for Cat! Cats are cute pets that love to purr and play.", "gu": "સી એટલે કેટ! બિલાડીઓ સુંદર પાળતુ પ્રાણી છે જેને મ્યાઉં કરવું અને રમવું ગમે છે.", "hi": "सी से कैट! बिल्लियां प्यारे पालतू जानवर हैं जिन्हें म्याऊं करना और खेलना पसंद है।"}'::jsonb, 
  '{"en": "Cats have soft fur, long whiskers, and are very good at jumping and climbing!", "gu": "બિલાડીઓને નરમ રૂંવાટી, લાંબી મૂછો હોય છે અને તે કૂદવામાં અને ચઢવામાં ખૂબ જ કુશળ હોય છે!", "hi": "बिल्लियों के पास मुलायम फर, लंबी मूंछें होती हैं, और वे कूदने और चढ़ने में बहुत अच्छी होती हैं!"}'::jsonb, 
  '{"en": "Did you know? Cats can make over 100 different sounds, while dogs can only make about 10!", "gu": "શું તમે જાણો છો? બિલાડીઓ ૧૦૦ થી વધુ વિવિધ અવાજો કરી શકે છે, જ્યારે કૂતરા ફક્ત ૧૦ કરી શકે છે!", "hi": "क्या आपको पता है? बिल्लियां 100 से अधिक विभिन्न आवाजें निकाल सकती हैं, जबकि कुत्ते केवल 10 के करीब!"}'::jsonb, 
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

INSERT INTO public.alphabet 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'd', 
  (SELECT id FROM categories WHERE category_key = 'alphabet' OR category_key = 'abc_alphabets' LIMIT 1), 
  '{"en": "D", "gu": "D", "hi": "D"}'::jsonb, 
  'https://pdhqylmzjdkvdbnezwhq.supabase.co/storage/v1/object/public/assets/alphabets/d.svg', 
  '{"en": "D is for Dog! Dogs are loyal pets that love to wag their tails.", "gu": "ડી એટલે ડોગ! કૂતરા વફાદાર પાળતુ પ્રાણી છે જેમને પૂંછડી પટપટાવવી ગમે છે.", "hi": "डी से डॉग! कुत्ते वफादार पालतू जानवर हैं जिन्हें अपनी पूंछ हिलाना पसंद है।"}'::jsonb, 
  '{"en": "Dogs have a great sense of smell and love to play fetch and go for walks!", "gu": "કૂતરાઓની સૂંઘવાની શક્તિ અદ્ભુત હોય છે અને તેમને વસ્તુઓ પકડવી અને ફરવા જવું ગમે છે!", "hi": "कुत्तों के पास सूंघने की बेहतरीन शक्ति होती है और उन्हें चीजें पकड़ना और टहलना बहुत पसंद होता है!"}'::jsonb, 
  '{"en": "Did you know? Dogs can understand up to 250 words and gestures, making them very smart!", "gu": "શું તમે જાણો છો? કૂતરા ૨૫૦ જેટલા શબ્દો અને ઈશારા સમજી શકે છે, જે તેમને ખૂબ સ્માર્ટ બનાવે છે!", "hi": "क्या आपको पता है? कुत्ते 250 शब्दों और इशारों को समझ सकते हैं, जिससे वे बहुत समझदार होते हैं!"}'::jsonb, 
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

INSERT INTO public.alphabet 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'e', 
  (SELECT id FROM categories WHERE category_key = 'alphabet' OR category_key = 'abc_alphabets' LIMIT 1), 
  '{"en": "E", "gu": "E", "hi": "E"}'::jsonb, 
  'https://pdhqylmzjdkvdbnezwhq.supabase.co/storage/v1/object/public/assets/alphabets/e.svg', 
  '{"en": "E is for Elephant! Elephants are the largest land animals.", "gu": "ઇ એટલે એલિફન્ટ! હાથી જમીન પરના સૌથી મોટા પ્રાણીઓ છે.", "hi": "ई से एलीफेंट! हाथी जमीन पर रहने वाले सबसे बड़े जानवर हैं।"}'::jsonb, 
  '{"en": "They have long trunks for breathing and spraying water, and very big ears!", "gu": "તેમની પાસે શ્વાસ લેવા અને પાણી છાંટવા માટે લાંબી સૂંઢ અને ખૂબ મોટા કાન હોય છે!", "hi": "उनके पास सांस लेने और पानी छिड़कने के लिए लंबी सूंड होती है, और बहुत बड़े कान होते हैं!"}'::jsonb, 
  '{"en": "Did you know? Elephants can swim! They use their trunks like snorkels in deep water.", "gu": "શું તમે જાણો છો? હાથીઓ તરી શકે છે! તેઓ ઊંડા પાણીમાં તેમની સૂંઢનો ઉપયોગ શ્વાસ લેવા માટે કરે છે.", "hi": "क्या आपको पता है? हाथी तैर सकते हैं! वे गहरे पानी में सांस लेने के लिए अपनी सूंड का इस्तेमाल करते हैं।"}'::jsonb, 
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

INSERT INTO public.alphabet 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'f', 
  (SELECT id FROM categories WHERE category_key = 'alphabet' OR category_key = 'abc_alphabets' LIMIT 1), 
  '{"en": "F", "gu": "F", "hi": "F"}'::jsonb, 
  'https://pdhqylmzjdkvdbnezwhq.supabase.co/storage/v1/object/public/assets/alphabets/f.svg', 
  '{"en": "F is for Fish! Fish live underwater and swim with their fins.", "gu": "એફ એટલે ફિશ! માછલીઓ પાણીની નીચે રહે છે અને તેમના મીનપક્ષોથી તરે છે.", "hi": "एफ से फिश! मछलियां पानी के नीचे रहती हैं और अपने पंखों से तैरती हैं।"}'::jsonb, 
  '{"en": "Fish breathe underwater using gills and come in many bright, beautiful colors!", "gu": "માછલીઓ ઝાલરની મદદથી પાણીની અંદર શ્વાસ લે છે અને તે ઘણા તેજસ્વી, સુંદર રંગોમાં આવે છે!", "hi": "मछलियां गलफड़ों का उपयोग करके पानी के भीतर सांस लेती हैं और कई चमकीले, सुंदर रंगों में आती हैं!"}'::jsonb, 
  '{"en": "Did you know? Some fish, like goldfish, can remember things for up to five months!", "gu": "શું તમે જાણો છો? ગોલ્ડફિશ જેવી કેટલીક માછલીઓ પાંચ મહિના સુધી વસ્તુઓ યાદ રાખી શકે છે!", "hi": "क्या आपको पता है? कुछ मछलियां, जैसे गोल्डफिश, पांच महीने तक चीजें याद रख सकती हैं!"}'::jsonb, 
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

INSERT INTO public.alphabet 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'g', 
  (SELECT id FROM categories WHERE category_key = 'alphabet' OR category_key = 'abc_alphabets' LIMIT 1), 
  '{"en": "G", "gu": "G", "hi": "G"}'::jsonb, 
  'https://pdhqylmzjdkvdbnezwhq.supabase.co/storage/v1/object/public/assets/alphabets/g.svg', 
  '{"en": "G is for Grapes! Grapes are sweet, juicy berries that grow in bunches.", "gu": "જી એટલે ગ્રેપ્સ! દ્રાક્ષ મીઠી, રસદાર બેરી છે જે ઝુમખામાં ઉગે છે.", "hi": "जी से ग्रेप्स! अंगूर मीठे, रसीले फल हैं जो गुच्छों में उगते हैं।"}'::jsonb, 
  '{"en": "Grapes can be green, red, or purple. They are delicious and healthy to eat!", "gu": "દ્રાક્ષ લીલી, લાલ કે જાંબલી હોઈ શકે છે. તે ખાવામાં સ્વાદિષ્ટ અને આરોગ્યપ્રદ છે!", "hi": "अंगूर हरे, लाल या बैंगनी हो सकते हैं। वे खाने में स्वादिष्ट और स्वास्थ्यवर्धक होते हैं!"}'::jsonb, 
  '{"en": "Did you know? Grapes are actually botanical berries, and about 8,000 grapes make a bottle of juice!", "gu": "શું તમે જાણો છો? દ્રાક્ષ વાસ્તવમાં બેરી છે, અને જ્યુસની એક બોટલ બનાવવા માટે લગભગ ૮,૦૦૦ દ્રાક્ષની જરૂર પડે છે!", "hi": "क्या आपको पता है? अंगूर वास्तव में बेरी हैं, और रस की एक बोतल बनाने के लिए लगभग 8,000 अंगूरों की आवश्यकता होती है!"}'::jsonb, 
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

INSERT INTO public.alphabet 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'h', 
  (SELECT id FROM categories WHERE category_key = 'alphabet' OR category_key = 'abc_alphabets' LIMIT 1), 
  '{"en": "H", "gu": "H", "hi": "H"}'::jsonb, 
  'https://pdhqylmzjdkvdbnezwhq.supabase.co/storage/v1/object/public/assets/alphabets/h.svg', 
  '{"en": "H is for Hat! Hats are worn on our heads to keep us warm or block the sun.", "gu": "એચ એટલે હેટ! હેટ માથા પર પહેરવામાં આવે છે જેથી આપણને ગરમી મળે અથવા સૂર્ય રોકી શકાય.", "hi": "एच से हैट! टोपी हमारे सिर पर पहनी जाती है ताकि हमें गर्मी मिले या धूप से बचाया जा सके।"}'::jsonb, 
  '{"en": "Hats come in many styles, like baseball caps, sun hats, and warm beanies!", "gu": "ટોપીઓ ઘણી શૈલીઓમાં આવે છે, જેમ કે બેઝબોલ કેપ્સ, સન હેટ્સ અને ગરમ ટોપીઓ!", "hi": "टोपियां कई शैलियों में आती हैं, जैसे बेसबॉल कैप, धूप से बचाने वाली टोपियां और गर्म ऊनी टोपियां!"}'::jsonb, 
  '{"en": "Did you know? The earliest known hat was worn by a bronze-age man found frozen in a glacier!", "gu": "શું તમે જાણો છો? જાણીતી સૌથી જૂની ટોપી ગ્લેશિયરમાં થીજી ગયેલા બ્રોન્ઝ યુગના માણસે પહેરી હતી!", "hi": "क्या आपको पता है? सबसे पहले ज्ञात टोपी एक कांस्य युग के व्यक्ति द्वारा पहनी गई थी जो ग्लेशियर में जमे मिले थे!"}'::jsonb, 
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

INSERT INTO public.alphabet 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'i', 
  (SELECT id FROM categories WHERE category_key = 'alphabet' OR category_key = 'abc_alphabets' LIMIT 1), 
  '{"en": "I", "gu": "I", "hi": "I"}'::jsonb, 
  'https://pdhqylmzjdkvdbnezwhq.supabase.co/storage/v1/object/public/assets/alphabets/i.svg', 
  '{"en": "I is for Ice Cream! Ice cream is a cold, sweet, and delicious treat.", "gu": "આઈ એટલે આઈસ્ક્રીમ! આઈસ્ક્રીમ એક ઠંડી, મીઠી અને સ્વાદિષ્ટ મીઠાઈ છે.", "hi": "आई से आइसक्रीम! आइसक्रीम एक ठंडी, मीठी और स्वादिष्ट मिठाई है।"}'::jsonb, 
  '{"en": "It comes in many flavors like chocolate, vanilla, strawberry, and mango!", "gu": "તે ચોકલેટ, વેનીલા, સ્ટ્રોબેરી અને મેંગો જેવા ઘણા સ્વાદોમાં આવે છે!", "hi": "यह चॉकलेट, वेनिला, स्ट्रॉबेरी और आम जैसे कई स्वादों में आती है!"}'::jsonb, 
  '{"en": "Did you know? The tallest ice cream cone ever made was over 9 feet tall in Italy!", "gu": "શું તમે જાણો છો? ઇટાલીમાં બનેલો અત્યાર સુધીનો સૌથી ઊંચો આઇસક્રીમ કોન ૯ ફૂટથી વધુ ઊંચો હતો!", "hi": "क्या आपको पता है? इटली में बना अब तक का सबसे ऊंचा आइसक्रीम कोन 9 फीट से ज्यादा ऊंचा था!"}'::jsonb, 
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

INSERT INTO public.alphabet 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'j', 
  (SELECT id FROM categories WHERE category_key = 'alphabet' OR category_key = 'abc_alphabets' LIMIT 1), 
  '{"en": "J", "gu": "J", "hi": "J"}'::jsonb, 
  'https://pdhqylmzjdkvdbnezwhq.supabase.co/storage/v1/object/public/assets/alphabets/j.svg', 
  '{"en": "J is for Jellyfish! Jellyfish are transparent animals that drift in the ocean.", "gu": "જે એટલે જેલીફિશ! જેલીફિશ પારદર્શક પ્રાણીઓ છે જે સમુદ્રમાં તરે છે.", "hi": "जे से जेलीफिश! जेलीफिश पारदर्शी जानवर हैं जो समुद्र में बहते हैं।"}'::jsonb, 
  '{"en": "They have soft, jelly-like bodies and long tentacles that flow in the water!", "gu": "તેમની પાસે નરમ, જેલી જેવા શરીર અને લાંબા સ્પર્શકો હોય છે જે પાણીમાં વહે છે!", "hi": "उनके पास नरम, जेली जैसे शरीर और लंबे तंतु होते हैं जो पानी में तैरते हैं!"}'::jsonb, 
  '{"en": "Did you know? Jellyfish have been swimming in oceans for over 500 million years, older than dinosaurs!", "gu": "શું તમે જાણો છો? જેલીફિશ ૫૦૦ મિલિયન વર્ષોથી સમુદ્રમાં તરી રહી છે, જે ડાયનાસોર કરતા પણ જૂની છે!", "hi": "क्या आपको पता है? जेलीफिश 50 करोड़ से अधिक वर्षों से समुद्र में तैर रही हैं, जो डायनासोर से भी पुरानी हैं!"}'::jsonb, 
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

INSERT INTO public.alphabet 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'k', 
  (SELECT id FROM categories WHERE category_key = 'alphabet' OR category_key = 'abc_alphabets' LIMIT 1), 
  '{"en": "K", "gu": "K", "hi": "K"}'::jsonb, 
  'https://pdhqylmzjdkvdbnezwhq.supabase.co/storage/v1/object/public/assets/alphabets/k.svg', 
  '{"en": "K is for Kite! Kites are colorful toys that fly high in the windy sky.", "gu": "કે એટલે કાઈટ! પતંગ રંગબેરંગી રમકડાં છે જે પવનવાળા આકાશમાં ઊંચે ઉડે છે.", "hi": "के से काइट! पतंग रंग-बिरंगे खिलौने हैं जो हवादार आसमान में ऊंचे उड़ते हैं।"}'::jsonb, 
  '{"en": "We hold onto a string and watch the wind lift the kite high above the trees!", "gu": "આપણે દોરી પકડી રાખીએ છીએ અને પવન પતંગને વૃક્ષોથી ઉપર હવામાં ઉંચકે તે જોઈએ છીએ!", "hi": "हम एक धागे को पकड़ते हैं और हवा को पतंग को पेड़ों के ऊपर ऊंचा उठाते हुए देखते हैं!"}'::jsonb, 
  '{"en": "Did you know? Kites were invented in China over 2,000 years ago, originally used for military signals!", "gu": "શું તમે જાણો છો? પતંગોની શોધ ૨,૦૦૦ વર્ષ પહેલાં ચીનમાં થઈ હતી, જે મૂળ સૈન્ય સંકેતો માટે વપરાતી હતી!", "hi": "क्या आपको पता है? पतंगों का आविष्कार 2,000 साल से भी पहले चीन में हुआ था, मूल रूप से सैन्य संकेतों के लिए!"}'::jsonb, 
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

INSERT INTO public.alphabet 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'l', 
  (SELECT id FROM categories WHERE category_key = 'alphabet' OR category_key = 'abc_alphabets' LIMIT 1), 
  '{"en": "L", "gu": "L", "hi": "L"}'::jsonb, 
  'https://pdhqylmzjdkvdbnezwhq.supabase.co/storage/v1/object/public/assets/alphabets/l.svg', 
  '{"en": "L is for Leaf! Leaves grow on trees and plants to help them breathe.", "gu": "એલ એટલે લીફ! પાંદડા વૃક્ષો અને છોડ પર ઉગે છે જેથી તેમને શ્વાસ લેવામાં મદદ મળે.", "hi": "एल से लीफ! पत्तियां पेड़ों और पौधों पर उगती हैं ताकि उन्हें सांस लेने में मदद मिल सके।"}'::jsonb, 
  '{"en": "Leaves are green in summer and turn yellow, orange, and red in autumn!", "gu": "પાંદડા ઉનાળામાં લીલા હોય છે અને પાનખરમાં પીળા, નારંગી અને લાલ થઈ જાય છે!", "hi": "पत्तियां गर्मियों में हरी होती हैं और पतझड़ में पीली, नारंगी और लाल हो जाती हैं!"}'::jsonb, 
  '{"en": "Did you know? The giant water lily leaf can grow up to 8 feet wide and support a child''s weight!", "gu": "શું તમે જાણો છો? વિશાળ વોટર લીલીનું પાન ૮ ફૂટ પહોળું વધી શકે છે અને બાળકનું વજન સહન કરી શકે છે!", "hi": "क्या आपको पता है? विशाल वाटर लिली का पत्ता 8 फीट तक चौड़ा हो सकता है और बच्चे का वजन संभाल सकता है!"}'::jsonb, 
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

INSERT INTO public.alphabet 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'm', 
  (SELECT id FROM categories WHERE category_key = 'alphabet' OR category_key = 'abc_alphabets' LIMIT 1), 
  '{"en": "M", "gu": "M", "hi": "M"}'::jsonb, 
  'https://pdhqylmzjdkvdbnezwhq.supabase.co/storage/v1/object/public/assets/alphabets/m.svg', 
  '{"en": "M is for Monkey! Monkeys are playful animals that love to swing on trees.", "gu": "એમ એટલે મંકી! વાંદરાઓ તોફાની પ્રાણીઓ છે જેમને ઝાડ પર ઝૂલવું ગમે છે.", "hi": "एम से मंकी! बंदर चंचल जानवर हैं जिन्हें पेड़ों पर झूलना पसंद है।"}'::jsonb, 
  '{"en": "Monkeys use their long tails to balance and hold branches while searching for food!", "gu": "વાંદરાઓ ખોરાક શોધતી વખતે સંતુલન રાખવા અને ડાળીઓ પકડવા તેમની લાંબી પૂંછડીનો ઉપયોગ કરે છે!", "hi": "बंदर भोजन की तलाश करते समय संतुलन बनाने और शाखाओं को पकड़ने के लिए अपनी लंबी पूंछ का उपयोग करते हैं!"}'::jsonb, 
  '{"en": "Did you know? Monkeys can use tools, like rocks to crack open nuts, just like humans!", "gu": "શું તમે જાણો છો? વાંદરાઓ મનુષ્યની જેમ જ નટ્સ તોડવા માટે પથ્થર જેવા સાધનોનો ઉપયોગ કરી શકે છે!", "hi": "क्या आपको पता है? बंदर इंसानों की तरह ही नट्स तोड़ने के लिए पत्थरों जैसे औजारों का उपयोग कर सकते हैं!"}'::jsonb, 
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

INSERT INTO public.alphabet 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'n', 
  (SELECT id FROM categories WHERE category_key = 'alphabet' OR category_key = 'abc_alphabets' LIMIT 1), 
  '{"en": "N", "gu": "N", "hi": "N"}'::jsonb, 
  'https://pdhqylmzjdkvdbnezwhq.supabase.co/storage/v1/object/public/assets/alphabets/n.svg', 
  '{"en": "N is for Nest! Nests are cozy homes built by birds for their eggs.", "gu": "એન એટલે નેસ્ટ! માળો એ પક્ષીઓ દ્વારા તેમના ઇંડા માટે બનાવવામાં આવેલ આરામદાયક ઘર છે.", "hi": "एन से नेस्ट! घोंसला पक्षियों द्वारा अपने अंडों के लिए बनाया गया एक आरामदायक घर है।"}'::jsonb, 
  '{"en": "Birds use twigs, leaves, and grass to weave a safe, warm bowl in the trees.", "gu": "પક્ષીઓ ઝાડમાં સુરક્ષિત, ગરમ વાટકો બનાવવા માટે ડાળીઓ, પાંદડા અને ઘાસનો ઉપયોગ કરે છે.", "hi": "पक्षी पेड़ों में एक सुरक्षित, गर्म कटोरा बनाने के लिए टहनियों, पत्तियों और घास का उपयोग करते हैं।"}'::jsonb, 
  '{"en": "Did you know? Some nests are tiny like a thimble, while others can be as large as a car!", "gu": "શું તમે જાણો છો? કેટલાક માળા અંગૂઠા જેવા નાના હોય છે, જ્યારે અન્ય કાર જેટલા મોટા હોઈ શકે છે!", "hi": "क्या आपको पता है? कुछ घोंसले अंगूठे के कवर जितने छोटे होते हैं, जबकि अन्य कार जितने बड़े हो सकते हैं!"}'::jsonb, 
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

INSERT INTO public.alphabet 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'o', 
  (SELECT id FROM categories WHERE category_key = 'alphabet' OR category_key = 'abc_alphabets' LIMIT 1), 
  '{"en": "O", "gu": "O", "hi": "O"}'::jsonb, 
  'https://pdhqylmzjdkvdbnezwhq.supabase.co/storage/v1/object/public/assets/alphabets/o.svg', 
  '{"en": "O is for Orange! Oranges are round, sweet, and juicy citrus fruits.", "gu": "ઓ એટલે ઓરેન્જ! નારંગી ગોળ, મીઠા અને રસદાર સાઇટ્રસ ફળો છે.", "hi": "ओ से ऑरेंज! संतरे गोल, मीठे और रसीले खट्टे फल होते हैं।"}'::jsonb, 
  '{"en": "They are packed with Vitamin C, which helps keep you strong and healthy!", "gu": "તેઓ વિટામિન સી થી ભરપૂર હોય છે, જે તમને મજબૂત અને સ્વસ્થ રાખવામાં મદદ કરે છે!", "hi": "वे विटामिन सी से भरपूर होते हैं, जो आपको मजबूत और स्वस्थ रखने में मदद करता है!"}'::jsonb, 
  '{"en": "Did you know? Oranges are actually a hybrid of mandarins and pomelos, created long ago!", "gu": "શું તમે જાણો છો? નારંગી વાસ્તવમાં મેન્ડરિન અને પોમેલોની સંકર પ્રજાતિ છે, જે લાંબા સમય પહેલા બનાવાઈ હતી!", "hi": "क्या आपको पता है? संतरे वास्तव में मंदारिन और चकोतरा की संकर नस्ल हैं, जो बहुत पहले बनाई गई थी!"}'::jsonb, 
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

INSERT INTO public.alphabet 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'p', 
  (SELECT id FROM categories WHERE category_key = 'alphabet' OR category_key = 'abc_alphabets' LIMIT 1), 
  '{"en": "P", "gu": "P", "hi": "P"}'::jsonb, 
  'https://pdhqylmzjdkvdbnezwhq.supabase.co/storage/v1/object/public/assets/alphabets/p.svg', 
  '{"en": "P is for Pear! Pears are sweet, bell-shaped fruits that grow on trees.", "gu": "પી એટલે પિઅર! નાશપતિ મીઠા, ઘંટ આકારના ફળો છે જે ઝાડ પર ઉગે છે.", "hi": "पी से पियर! नाशपाती मीठे, घंटी के आकार के फल हैं जो पेड़ों पर उगते हैं।"}'::jsonb, 
  '{"en": "Pears can be green, yellow, or red. They are juicy and soft when ripe!", "gu": "નાશપતિ લીલી, પીળી કે લાલ હોઈ શકે છે. તે પાકે ત્યારે રસદાર અને નરમ હોય છે!", "hi": "नाशपाती हरी, पीली या लाल हो सकती है। वे पकने पर रसीली और मुलायम होती हैं!"}'::jsonb, 
  '{"en": "Did you know? Pear trees can produce fruit for up to 75 years, and they belong to the rose family!", "gu": "શું તમે જાણો છો? નાશપતિના ઝાડ ૭૫ વર્ષ સુધી ફળ આપી શકે છે, અને તે ગુલાબ પરિવારના છે!", "hi": "क्या आपको पता है? नाशपाती के पेड़ 75 साल तक फल दे सकते हैं, और वे गुलाब परिवार से संबंधित हैं!"}'::jsonb, 
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

INSERT INTO public.alphabet 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'q', 
  (SELECT id FROM categories WHERE category_key = 'alphabet' OR category_key = 'abc_alphabets' LIMIT 1), 
  '{"en": "Q", "gu": "Q", "hi": "Q"}'::jsonb, 
  'https://pdhqylmzjdkvdbnezwhq.supabase.co/storage/v1/object/public/assets/alphabets/q.svg', 
  '{"en": "Q is for Queen! A queen is a female ruler of a royal kingdom.", "gu": "ક્યુ એટલે ક્વીન! રાણી એ શાહી રાજ્યની સ્ત્રી શાસક છે.", "hi": "क्यू से क्वीन! रानी एक शाही साम्राज्य की महिला शासक होती है।"}'::jsonb, 
  '{"en": "Queens wear beautiful golden crowns and live in historic castles!", "gu": "રાણીઓ સુંદર સોનાના મુગટ પહેરે છે અને ઐતિહાસિક કિલ્લાઓમાં રહે છે!", "hi": "रानियां सुंदर सोने के मुकुट पहनती हैं और ऐतिहासिक महलों में रहती हैं!"}'::jsonb, 
  '{"en": "Did you know? Queen Elizabeth the Second was the longest-reigning queen in world history!", "gu": "શું તમે જાણો છો? રાણી એલિઝાબેથ દ્વિતીય વિશ્વના ઇતિહાસમાં સૌથી લાંબો સમય શાસન કરનાર રાણી હતા!", "hi": "क्या आपको पता है? रानी एलिजाबेथ द्वितीय विश्व इतिहास में सबसे लंबे समय तक शासन करने वाली रानी थीं!"}'::jsonb, 
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

INSERT INTO public.alphabet 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'r', 
  (SELECT id FROM categories WHERE category_key = 'alphabet' OR category_key = 'abc_alphabets' LIMIT 1), 
  '{"en": "R", "gu": "R", "hi": "R"}'::jsonb, 
  'https://pdhqylmzjdkvdbnezwhq.supabase.co/storage/v1/object/public/assets/alphabets/r.svg', 
  '{"en": "R is for Ring! Rings are circular jewelry worn on our fingers.", "gu": "આર એટલે રિંગ! વીંટી એ આંગળીઓ પર પહેરવામાં આવતા ગોળાકાર ઘરેણાં છે.", "hi": "आर से रिंग! अंगूठी उंगलियों पर पहने जाने वाले गोलाकार आभूषण हैं।"}'::jsonb, 
  '{"en": "Rings are often made of gold or silver and can hold sparkling diamonds or gems!", "gu": "વીંટી ઘણીવાર સોના કે ચાંદીની બનેલી હોય છે અને તેમાં ચમકતા હીરા અથવા રત્નો હોઈ શકે છે!", "hi": "अंगूठियां अक्सर सोने या चांदी की बनी होती हैं और उनमें चमकीले हीरे या रत्न हो सकते हैं!"}'::jsonb, 
  '{"en": "Did you know? In ancient Rome, people wore rings made of iron to show strength and commitment!", "gu": "શું તમે જાણો છો? પ્રાચીન રોમમાં લોકો શક્તિ અને પ્રતિબદ્ધતા દર્શાવવા લોખંડની બનેલી વીંટી પહેરતા હતા!", "hi": "क्या आपको पता है? प्राचीन रोम में, लोग ताकत और प्रतिबद्धता दिखाने के लिए लोहे की अंगूठियां पहनते थे!"}'::jsonb, 
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

INSERT INTO public.alphabet 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  's', 
  (SELECT id FROM categories WHERE category_key = 'alphabet' OR category_key = 'abc_alphabets' LIMIT 1), 
  '{"en": "S", "gu": "S", "hi": "S"}'::jsonb, 
  'https://pdhqylmzjdkvdbnezwhq.supabase.co/storage/v1/object/public/assets/alphabets/s.svg', 
  '{"en": "S is for Sun! The sun is a giant, hot star at the center of our solar system.", "gu": "એસ એટલે સન! સૂર્ય આપણી સૌરમંડળના કેન્દ્રમાં આવેલો એક વિશાળ, ગરમ તારો છે.", "hi": "एस से सन! सूर्य हमारे सौरमंडल के केंद्र में स्थित एक विशाल, गर्म तारा है।"}'::jsonb, 
  '{"en": "The sun gives us light and warmth, which helps plants grow and keeps us active!", "gu": "સૂર્ય આપણને પ્રકાશ અને ગરમી આપે છે, જે છોડને વધવામાં મદદ કરે છે અને આપણને સક્રિય રાખે છે!", "hi": "सूर्य हमें प्रकाश और गर्मी देता है, जो पौधों को बढ़ने में मदद करता है और हमें सक्रिय रखता है!"}'::jsonb, 
  '{"en": "Did you know? One million Earths could fit inside the sun! That is how huge it is.", "gu": "શું તમે જાણો છો? સૂર્યની અંદર દસ લાખ પૃથ્વી સમાઈ શકે છે! તે એટલો વિશાળ છે.", "hi": "क्या आपको पता है? सूर्य के भीतर दस लाख पृथ्वी समा सकती हैं! वह इतना विशाल है।"}'::jsonb, 
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

INSERT INTO public.alphabet 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  't', 
  (SELECT id FROM categories WHERE category_key = 'alphabet' OR category_key = 'abc_alphabets' LIMIT 1), 
  '{"en": "T", "gu": "T", "hi": "T"}'::jsonb, 
  'https://pdhqylmzjdkvdbnezwhq.supabase.co/storage/v1/object/public/assets/alphabets/t.svg', 
  '{"en": "T is for Tree! Trees are tall, strong plants that provide shade and oxygen.", "gu": "ટી એટલે ટ્રી! વૃક્ષો ઊંચા, મજબૂત છોડ છે જે છાંયડો અને ઓક્સિજન આપે છે.", "hi": "टी से ट्री! पेड़ ऊंचे, मजबूत पौधे होते हैं जो छाया और ऑक्सीजन प्रदान करते हैं।"}'::jsonb, 
  '{"en": "Trees have trunks, branches, and leaves. They are homes to many birds and squirrels!", "gu": "વૃક્ષોને થડ, ડાળીઓ અને પાંદડા હોય છે. તે ઘણા પક્ષીઓ અને ખિસકોલીઓનું ઘર છે!", "hi": "पेड़ों में तने, शाखाएं और पत्तियां होती हैं। वे कई पक्षियों और गिलहरियों के घर होते हैं!"}'::jsonb, 
  '{"en": "Did you know? Trees can communicate with each other through underground root networks!", "gu": "શું તમે જાણો છો? વૃક્ષો જમીનની અંદર મૂળના નેટવર્ક દ્વારા એકબીજા સાથે વાતચીત કરી શકે છે!", "hi": "क्या आपको पता है? पेड़ जमीन के नीचे जड़ों के जाल के जरिए एक-दूसरे से संवाद कर सकते हैं!"}'::jsonb, 
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

INSERT INTO public.alphabet 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'u', 
  (SELECT id FROM categories WHERE category_key = 'alphabet' OR category_key = 'abc_alphabets' LIMIT 1), 
  '{"en": "U", "gu": "U", "hi": "U"}'::jsonb, 
  'https://pdhqylmzjdkvdbnezwhq.supabase.co/storage/v1/object/public/assets/alphabets/u.svg', 
  '{"en": "U is for Umbrella! Umbrellas keep us dry when it rains.", "gu": "યુ એટલે અમબ્રેલા! છત્રી આપણને વરસાદ પડે ત્યારે સૂકા રાખે છે.", "hi": "यू से अम्ब्रेला! छतरियां हमें बारिश होने पर सूखा रखती हैं।"}'::jsonb, 
  '{"en": "We open them over our heads to block the raindrops or shade us from the hot sun!", "gu": "આપણે વરસાદના ટીપાં રોકવા અથવા સૂર્યથી બચવા માટે તેને માથા પર ખોલીએ છીએ!", "hi": "हम बारिश की बूंदों को रोकने या धूप से बचने के लिए उन्हें अपने सिर के ऊपर खोलते हैं!"}'::jsonb, 
  '{"en": "Did you know? The word umbrella comes from the Latin word ''umbra'', which means shade!", "gu": "શું તમે જાણો છો? અમ્બ્રેલા શબ્દ લેટિન શબ્દ ''umbra'' પરથી આવ્યો છે, જેનો અર્થ છાંયડો થાય છે!", "hi": "क्या आपको पता है? अम्ब्रेला शब्द लैटिन शब्द ''umbra'' से आया है, जिसका अर्थ छाया होता है!"}'::jsonb, 
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

INSERT INTO public.alphabet 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'v', 
  (SELECT id FROM categories WHERE category_key = 'alphabet' OR category_key = 'abc_alphabets' LIMIT 1), 
  '{"en": "V", "gu": "V", "hi": "V"}'::jsonb, 
  'https://pdhqylmzjdkvdbnezwhq.supabase.co/storage/v1/object/public/assets/alphabets/v.svg', 
  '{"en": "V is for Vase! A vase is a beautiful container used to hold flowers.", "gu": "વી એટલે વાઝ! ફૂલદાની એ ફૂલો રાખવા માટે વપરાતું એક સુંદર પાત્ર છે.", "hi": "वी से वाज़! फूलदान फूलों को रखने के लिए इस्तेमाल किया जाने वाला एक सुंदर बर्तन है।"}'::jsonb, 
  '{"en": "We fill it with water and put colorful roses, daisies, or lilies inside to decorate!", "gu": "આપણે તેને પાણીથી ભરીએ છીએ અને સજાવટ માટે અંદર રંગબેરંગી ગુલાબ અથવા મોગરા રાખીએ છીએ!", "hi": "हम इसे पानी से भरते हैं और सजाने के लिए इसके अंदर रंग-बिरंगे गुलाब या चमेली रखते हैं!"}'::jsonb, 
  '{"en": "Did you know? The oldest ceramic vases ever found are over 10,000 years old, made in China!", "gu": "શું તમે જાણો છો? અત્યાર સુધી મળેલી સૌથી જૂની ફૂલદાની ૧૦,૦૦૦ વર્ષથી વધુ જૂની છે, જે ચીનમાં બની હતી!", "hi": "क्या आपको पता है? अब तक पाए गए सबसे पुराने चीनी मिट्टी के फूलदान 10,000 साल से भी अधिक पुराने हैं, जो चीन में बने थे!"}'::jsonb, 
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

INSERT INTO public.alphabet 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'w', 
  (SELECT id FROM categories WHERE category_key = 'alphabet' OR category_key = 'abc_alphabets' LIMIT 1), 
  '{"en": "W", "gu": "W", "hi": "W"}'::jsonb, 
  'https://pdhqylmzjdkvdbnezwhq.supabase.co/storage/v1/object/public/assets/alphabets/w.svg', 
  '{"en": "W is for Watermelon! Watermelons are large, sweet, and juicy summer fruits.", "gu": "ડબલ્યુ એટલે વોટરમેલન! તરબૂચ મોટા, મીઠા અને રસદાર ઉનાળાના ફળો છે.", "hi": "डब्ल्यू से वाटरमेलन! तरबूज गर्मियों के बड़े, मीठे और रसीले फल होते हैं।"}'::jsonb, 
  '{"en": "They have a green rind on the outside, and a sweet red inside with black seeds!", "gu": "તેમને બહારથી લીલી છાલ હોય છે, અને કાળા બીજ સાથે અંદરનો ભાગ મીઠો અને લાલ હોય છે!", "hi": "उनके बाहर एक हरा छिलका होता है, और काले बीजों के साथ अंदर का हिस्सा मीठा और लाल होता है!"}'::jsonb, 
  '{"en": "Did you know? Watermelons are 92 percent water, making them perfect for staying hydrated!", "gu": "શું તમે જાણો છો? તરબૂચમાં ૯૨ ટકા પાણી હોય છે, જે આપણને હાઇડ્રેટેડ રાખવા માટે શ્રેષ્ઠ બનાવે છે!", "hi": "क्या आपको पता है? तरबूज में 92 प्रतिशत पानी होता है, जो हमें हाइड्रेटेड रखने के लिए सबसे अच्छा है!"}'::jsonb, 
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

INSERT INTO public.alphabet 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'x', 
  (SELECT id FROM categories WHERE category_key = 'alphabet' OR category_key = 'abc_alphabets' LIMIT 1), 
  '{"en": "X", "gu": "X", "hi": "X"}'::jsonb, 
  'https://pdhqylmzjdkvdbnezwhq.supabase.co/storage/v1/object/public/assets/alphabets/x.svg', 
  '{"en": "X is for Xylophone! A xylophone is a musical instrument with colorful bars.", "gu": "એક્સ એટલે ઝાયલોફોન! ઝાયલોફોન એ રંગબેરંગી પટ્ટીઓ ધરાવતું સંગીતનું સાધન છે.", "hi": "एक्स से ज़ायलोफ़ोन! ज़ायलोफ़ोन रंग-बिरंगी पट्टियों वाला एक संगीत वाद्ययंत्र है।"}'::jsonb, 
  '{"en": "We hit the bars with mallets to make bright, happy bell-like sounds!", "gu": "આપણે તેજસ્વી, ખુશ ઘંટ જેવા અવાજો કરવા માટે લાકડીઓથી પટ્ટીઓ પર પ્રહાર કરીએ છીએ!", "hi": "हम चमकीली, खुश घंटी जैसी आवाजें निकालने के लिए छड़ियों से पट्टियों पर प्रहार करते हैं!"}'::jsonb, 
  '{"en": "Did you know? The name xylophone comes from Greek words meaning ''wood sound''!", "gu": "શું તમે જાણો છો? ઝાયલોફોન નામ ગ્રીક શબ્દો પરથી આવ્યું છે જેનો અર્થ ''લાકડાનો અવાજ'' થાય છે!", "hi": "क्या आपको पता है? ज़ायलोफ़ोन नाम ग्रीक शब्दों से आया है जिसका अर्थ ''लकड़ी की आवाज़'' होता है!"}'::jsonb, 
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

INSERT INTO public.alphabet 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'y', 
  (SELECT id FROM categories WHERE category_key = 'alphabet' OR category_key = 'abc_alphabets' LIMIT 1), 
  '{"en": "Y", "gu": "Y", "hi": "Y"}'::jsonb, 
  'https://pdhqylmzjdkvdbnezwhq.supabase.co/storage/v1/object/public/assets/alphabets/y.svg', 
  '{"en": "Y is for Yo-yo! A yo-yo is a fun toy that goes up and down on a string.", "gu": "વાય એટલે યો-યો! યો-યો એક મનોરંજક રમકડાં છે જે દોરી પર ઉપર અને નીચે જાય છે.", "hi": "वाई से यो-यो! यो-यो एक मजेदार खिलौना है जो धागे पर ऊपर और नीचे जाता है।"}'::jsonb, 
  '{"en": "We wind the string, drop the yo-yo, and pull it back up using a finger loop!", "gu": "આપણે દોરી લપેટીએ છીએ, યો-યો છોડીએ છીએ અને આંગળીના લૂપનો ઉપયોગ કરીને તેને પાછું ખેંચીએ છીએ!", "hi": "हम धागा लपेटते हैं, यो-यो छोड़ते हैं और उंगली के लूप का उपयोग करके इसे वापस खींचते हैं!"}'::jsonb, 
  '{"en": "Did you know? Yo-yos are the second oldest toys in history, only dolls are older!", "gu": "શું તમે જાણો છો? યો-યો ઇતિહાસમાં બીજા ક્રમનું સૌથી જૂનું રમકડું છે, માત્ર ઢીંગલીઓ તેનાથી જૂની છે!", "hi": "क्या आपको पता है? यो-यो इतिहास में दूसरा सबसे पुराना खिलौना है, केवल गुड़िया उससे पुरानी हैं!"}'::jsonb, 
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

INSERT INTO public.alphabet 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'z', 
  (SELECT id FROM categories WHERE category_key = 'alphabet' OR category_key = 'abc_alphabets' LIMIT 1), 
  '{"en": "Z", "gu": "Z", "hi": "Z"}'::jsonb, 
  'https://pdhqylmzjdkvdbnezwhq.supabase.co/storage/v1/object/public/assets/alphabets/z.svg', 
  '{"en": "Z is for Zebra! Zebras are wild horses with black and white stripes.", "gu": "ઝેડ એટલે ઝીબ્રા! ઝીબ્રા કાળી અને સફેદ પટ્ટીઓવાળા જંગલી ઘોડા છે.", "hi": "जेड से ज़ीब्रा! ज़ीब्रा काली और सफेद धारियों वाले जंगली घोड़े हैं।"}'::jsonb, 
  '{"en": "They live in herds in Africa and run very fast to escape predators like lions!", "gu": "તેઓ આફ્રિકામાં ટોળામાં રહે છે અને સિંહ જેવા શિકારીઓથી બચવા માટે ખૂબ જ ઝડપથી દોડે છે!", "hi": "वे अफ्रीका में झुंड में रहते हैं और शेर जैसे शिकारियों से बचने के लिए बहुत तेजी से दौड़ते हैं!"}'::jsonb, 
  '{"en": "Did you know? No two zebras have the same stripes! They are unique, just like fingerprints.", "gu": "શું તમે જાણો છો? કોઈપણ બે ઝીબ્રા પર સમાન પટ્ટીઓ હોતી નથી! તેઓ ફિંગરપ્રિન્ટની જેમ જ અનન્ય છે.", "hi": "क्या आपको पता है? किन्हीं दो ज़ीब्रा पर एक जैसी धारियां नहीं होती हैं! वे उंगलियों के निशान की तरह ही अद्वितीय हैं।"}'::jsonb, 
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