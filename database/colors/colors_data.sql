-- 1. Create colors table

CREATE TABLE IF NOT EXISTS public.colors (
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
  constraint colors_pkey primary key (id),
  constraint colors_topic_key_key unique (topic_key),
  constraint colors_category_id_fkey foreign KEY (category_id) references categories (id) on delete CASCADE
) TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS idx_colors_topic_key on public.colors using btree (topic_key) TABLESPACE pg_default;

ALTER TABLE public.colors DISABLE ROW LEVEL SECURITY;

GRANT ALL ON public.colors TO anon;
GRANT ALL ON public.colors TO authenticated;
GRANT ALL ON public.colors TO service_role;


-- 2. Reset sequence & insert category

SELECT setval(
  pg_get_serial_sequence('public.categories', 'id'),
  COALESCE((SELECT MAX(id) FROM public.categories), 0) + 1,
  false
);

INSERT INTO public.categories (category_key, title, color, is_premium, group_id, display_order)
VALUES (
  'colors',
  '{"en": "Colors", "gu": "રંગો", "hi": "रंग"}'::jsonb,
  '#E91E63',
  false,
  'natures_world',
  22
)
ON CONFLICT (category_key) DO UPDATE SET
  title = EXCLUDED.title,
  color = EXCLUDED.color,
  group_id = EXCLUDED.group_id,
  display_order = EXCLUDED.display_order;


-- 3. Seed 19 colors

INSERT INTO public.colors (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'red',
  (SELECT id FROM categories WHERE category_key = 'colors' LIMIT 1),
  '{"en":"Red","gu":"લાલ","hi":"लाल"}'::jsonb,
  'assets/images/colors/red.png',
  '#F44336',
  '{"en":"Red! A bold, exciting color that grabs your attention!","gu":"લાલ! એક આકર્ષક અને સુંદર રંગ જે તમારું ધ્યાન ખેંચે છે!","hi":"लाल! एक साहसी, रोमांचक रंग जो आपका ध्यान खींचता है!"}'::jsonb,
  '{"en":"Red is one of the three primary colors. We see red in ripe apples, roses, fire trucks, and stop signs. Red is used the world over to mean stop or danger — because it is the easiest color for our eyes to spot!","gu":"લાલ ત્રણ મુખ્ય રંગોમાંનો એક છે. આપણે લાલ રંગ પાકા સફરજન, ગુલાબ, ફાયર બ્રિગેડની ગાડી અને સ્ટોપ સાઇનમાં જોઈએ છીએ. લાલ રંગનો ઉપયોગ દુનિયાભરમાં થોભવા અથવા ભય દર્શાવવા માટે થાય છે કારણ કે તે આપણી આંખો સરળતાથી જોઈ શકે છે.","hi":"लाल तीन प्राथमिक रंगों में से एक है। हम पके सेब, गुलाब, दमकल गाड़ियों और स्टॉप संकेतों में लाल रंग देखते हैं। पूरी दुनिया में लाल रंग का उपयोग रुकने या खतरे के लिए किया जाता है क्योंकि इसे हमारी आंखें सबसे आसानी से देख सकती हैं।"}'::jsonb,
  '{"en":"Did you know? Red is the first color that babies can see clearly after black and white — it is the most visible color on the spectrum!","gu":"શું તમે જાણો છો? કાળા અને સફેદ રંગ પછી નાના બાળકો જે પહેલો રંગ સ્પષ્ટપણે જોઈ શકે છે તે લાલ છે. તે સૌથી વધુ દેખાતો રંગ છે!","hi":"क्या आपको पता है? काले और सफेद के बाद लाल पहला ऐसा रंग है जिसे छोटे बच्चे सबसे पहले देख पाते हैं। यह स्पेक्ट्रम पर सबसे अधिक दिखाई देने वाला रंग है!"}'::jsonb,
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

INSERT INTO public.colors (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'blue',
  (SELECT id FROM categories WHERE category_key = 'colors' LIMIT 1),
  '{"en":"Blue","gu":"વાદળી","hi":"नीला"}'::jsonb,
  'assets/images/colors/blue.png',
  '#2196F3',
  '{"en":"Blue! The calm and cool color of the sky and ocean!","gu":"વાદળી! આકાશ અને સમુદ્રનો શાંત અને સુંદર રંગ!","hi":"नीला! आकाश और समुद्र का शांत और शीतल रंग!"}'::jsonb,
  '{"en":"Blue is a primary color. It is the color of the sky, ocean, and blueberries. Blue is considered a calming, trustful color — that is why many banks and hospitals use blue in their logos!","gu":"વાદળી એક મુખ્ય રંગ છે. તે આકાશ, સમુદ્ર અને બ્લૂબેરીનો રંગ છે. વાદળી રંગને શાંતિ અને વિશ્વાસનું પ્રતીક માનવામાં આવે છે, તેથી જ ઘણી બેંકો અને હોસ્પિટલો તેમના લોગોમાં વાદળી રંગનો ઉપયોગ કરે છે.","hi":"नीला एक प्राथमिक रंग है। यह आकाश, महासागर और ब्लूबेरी का रंग है। नीले रंग को शांति और विश्वास का प्रतीक माना जाता है, इसलिए कई बैंक और अस्पताल अपने लोगो में नीले रंग का उपयोग करते हैं।"}'::jsonb,
  '{"en":"Did you know? Blue is the world''s most popular favorite color! Studies show that over 40% of people choose blue as their top color.","gu":"શું તમે જાણો છો? વાદળી દુનિયાનો સૌથી લોકપ્રિય અને મનપસંદ રંગ છે! સંશોધનો દર્શાવે છે કે ૪૦ ટકાથી વધુ લોકો વાદળી રંગને પોતાનો પ્રિય રંગ પસંદ કરે છે.","hi":"क्या आपको पता है? नीला दुनिया का सबसे पसंदीदा रंग है! अध्ययनों से पता चलता है कि 40% से अधिक लोग नीले रंग को अपना सबसे पसंदीदा रंग चुनते हैं।"}'::jsonb,
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

INSERT INTO public.colors (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'yellow',
  (SELECT id FROM categories WHERE category_key = 'colors' LIMIT 1),
  '{"en":"Yellow","gu":"પીળો","hi":"पीला"}'::jsonb,
  'assets/images/colors/yellow.png',
  '#FFEB3B',
  '{"en":"Yellow! The bright and cheerful color of sunshine and happiness!","gu":"પીળો! સૂર્યપ્રકાશ અને ખુશીનો ચમકતો અને આનંદી રંગ!","hi":"पीला! धूप और खुशी का चमकीला और खुशहाल रंग!"}'::jsonb,
  '{"en":"Yellow is a primary color and one of the brightest in the spectrum. We see it in bananas, sunflowers, school buses, and the blazing sun. Yellow is the color our eyes can detect the fastest — that is why taxis and road signs are yellow!","gu":"પીળો એક મુખ્ય રંગ છે અને તે ખૂબ જ તેજસ્વી છે. આપણે તેને કેળા, સૂર્યમુખી, સ્કૂલ બસ અને તેજસ્વી સૂર્યમાં જોઈએ છીએ. પીળો રંગ આપણી આંખો સૌથી ઝડપથી ઓળખી શકે છે, તેથી જ ટેક્સી અને રોડ સાઇન પીળા રંગના હોય છે.","hi":"पीला एक प्राथमिक रंग है और यह सबसे चमकीले रंगों में से एक है। हम इसे केले, सूरजमुखी, स्कूल बसों और चमकते सूरज में देखते हैं। पीला रंग हमारी आंखें सबसे जल्दी पहचानती हैं, इसलिए टैक्सी और सड़क के संकेत पीले होते हैं।"}'::jsonb,
  '{"en":"Did you know? Yellow is the color the human eye processes the fastest! That''s why caution signs and taxis are yellow — to be noticed immediately.","gu":"શું તમે જાણો છો? માનવ આંખ પીળા રંગને સૌથી ઝડપથી ઓળખી શકે છે! તેથી જ ચેતવણીના બોર્ડ અને ટેક્સીઓ પીળા રંગની રાખવામાં આવે છે જેથી તરત જ ધ્યાન જાય.","hi":"क्या आपको पता है? पीला वह रंग है जिसे इंसानी आंख सबसे तेजी से पहचानती है! इसीलिए सावधानी के बोर्ड और टैक्सियां पीले रंग की होती हैं ताकि तुरंत ध्यान आकर्षित हो सके।"}'::jsonb,
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

INSERT INTO public.colors (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'green',
  (SELECT id FROM categories WHERE category_key = 'colors' LIMIT 1),
  '{"en":"Green","gu":"લીલો","hi":"हरा"}'::jsonb,
  'assets/images/colors/green.png',
  '#4CAF50',
  '{"en":"Green! The fresh color of nature, plants, and new life!","gu":"લીલો! કુદરત, વનસ્પતિ અને નવજીવનનો તાજગીસભર રંગ!","hi":"हरा! प्रकृति, पौधों और नए जीवन का ताजगी भरा रंग!"}'::jsonb,
  '{"en":"Green is a secondary color made by mixing blue and yellow. It is the color of leaves, grass, frogs, and emeralds. Green is strongly associated with nature, growth, and good health. In many countries, green traffic lights mean ''go!''","gu":"લીલો એ વાદળી અને પીળો રંગ મેળવીને બનતો ગૌણ રંગ છે. તે પાંદડા, ઘાસ, દેડકા અને પાના (રત્ન) નો રંગ છે. લીલો રંગ પ્રકૃતિ, વિકાસ અને સારા સ્વાસ્થ્ય સાથે જોડાયેલો છે. ટ્રાફિક સિગ્નલમાં લીલી લાઈટનો અર્થ થાય છે આગળ વધો!","hi":"हरा रंग नीले और पीले को मिलाकर बनता है। यह पत्तियों, घास, मेंढकों और पन्ने का रंग है। हरा रंग प्रकृति, विकास और अच्छे स्वास्थ्य से जुड़ा है। कई देशों में ट्रैफिक सिग्नल पर हरी बत्ती का मतलब चलना होता है!"}'::jsonb,
  '{"en":"Green is the easiest color on the human eye! That''s why surgeons wear green gowns — it helps their eyes stay relaxed during long operations.","gu":"લીલો રંગ માનવ આંખો માટે સૌથી શાંતિદાયક છે! તેથી જ ડોક્ટરો ઓપરેશન દરમિયાન લીલા કપડાં પહેરે છે, જેથી લાંબા સમય સુધી તેમની આંખો થાકે નહીં.","hi":"हरा रंग इंसानी आंखों के लिए सबसे आरामदायक होता है! इसीलिए डॉक्टर ऑपरेशन के दौरान हरे रंग के कपड़े पहनते हैं ताकि लंबे समय तक उनकी आंखों को आराम मिले।"}'::jsonb,
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

INSERT INTO public.colors (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'orange',
  (SELECT id FROM categories WHERE category_key = 'colors' LIMIT 1),
  '{"en":"Orange","gu":"નારંગી","hi":"नारंगी"}'::jsonb,
  'assets/images/colors/orange.png',
  '#FF9800',
  '{"en":"Orange! The warm, energetic color of ripe fruits and a glowing sunset!","gu":"નારંગી! પાકા ફળો અને સુંદર સૂર્યાસ્તનો ગરમ અને ઉર્જાવાન રંગ!","hi":"नारंगी! पके फलों और सुंदर सूर्यास्त का गर्म और ऊर्जावान रंग!"}'::jsonb,
  '{"en":"Orange is a secondary color made by mixing red and yellow. We see it in oranges, pumpkins, tigers, autumn leaves, and sunsets. Orange is a warm, energetic color that stands out in nature!","gu":"નારંગી એ લાલ અને પીળો રંગ મેળવીને બનતો ગૌણ રંગ છે. આપણે તેને સંતરા, કોળું, વાઘ, પાનખરના પાંદડા અને સૂર્યાસ્તમાં જોઈએ છીએ. નારંગી ખૂબ જ આકર્ષક અને ઉર્જાવાન રંગ છે.","hi":"नारंगी लाल और पीले रंग को मिलाकर बनने वाला रंग है। हम इसे संतरे, कद्दू, बाघों, पतझड़ के पत्तों और सूर्यास्त में देखते हैं। नारंगी एक गर्म और ऊर्जावान रंग है जो प्रकृति में अलग ही दिखाई देता है।"}'::jsonb,
  '{"en":"Did you know? Orange is the only color in English that is named after a fruit! The fruit came first — before the color even had a name, it was called ''yellow-red.''","gu":"શું તમે જાણો છો? અંગ્રેજી ભાષામાં ઓરેન્જ એકમાત્ર એવો રંગ છે જેનું નામ એક ફળ પરથી પડ્યું છે! પહેલા ફળ આવ્યું, તે પહેલાં આ રંગને પીળો-લાલ કહેવામાં આવતો હતો.","hi":"क्या आपको पता है? अंग्रेजी में ऑरेंज ही एकमात्र ऐसा रंग है जिसका नाम किसी फल के नाम पर रखा गया है! फल का नाम पहले आया था, उससे पहले इस रंग को पीला-लाल कहा जाता था।"}'::jsonb,
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

INSERT INTO public.colors (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'purple',
  (SELECT id FROM categories WHERE category_key = 'colors' LIMIT 1),
  '{"en":"Purple","gu":"જાંબલી","hi":"बैंगनी"}'::jsonb,
  'assets/images/colors/purple.png',
  '#9C27B0',
  '{"en":"Purple! The royal, magical color of kings, queens, and wizards!","gu":"જાંબલી! રાજાઓ, રાણીઓ અને જાદુગરોનો શાહી અને જાદુઈ રંગ!","hi":"बैंगनी! राजाओं, रानियों और जादूगरों का शाही और जादुई रंग!"}'::jsonb,
  '{"en":"Purple is made by mixing red and blue. We see purple in grapes, lavender flowers, amethyst crystals, and eggplants. Throughout history, purple dye was extremely rare and expensive, so only royalty could afford to wear it!","gu":"જાંબલી રંગ લાલ અને વાદળી મેળવીને બનાવવામાં આવે છે. આપણે દ્રાક્ષ, લેવેન્ડરના ફૂલો, રત્નો અને રીંગણમાં જાંબલી રંગ જોઈએ છીએ. ઇતિહાસમાં જાંબલી રંગ ખૂબ જ દુર્લભ અને મોંઘો હતો, તેથી માત્ર રાજા-મહારાજાઓ જ આ રંગના કપડાં પહેરતા હતા.","hi":"बैंगनी रंग लाल और नीले को मिलाकर बनाया जाता है। हम अंगूर, लैवेंडर के फूल, क्रिस्टल और बैंगन में बैंगनी रंग देखते हैं। इतिहास में बैंगनी रंग का डाई बहुत दुर्लभ और महंगा था, इसलिए केवल राजघराने के लोग ही इसे पहन सकते थे!"}'::jsonb,
  '{"en":"Did you know? In ancient Rome, only the Emperor was allowed to wear purple! Purple dye was made from sea snails and took 10,000 snails to make just 1 gram of dye!","gu":"શું તમે જાણો છો? પ્રાચીન રોમમાં માત્ર સમ્રાટને જ જાંબલી કપડાં પહેરવાની મંજૂરી હતી! આ રંગ દરિયાઈ શંખમાંથી બનતો હતો અને માત્ર ૧ ગ્રામ રંગ બનાવવા માટે ૧૦,૦૦૦ શંખની જરૂર પડતી હતી.","hi":"क्या आपको पता है? प्राचीन रोम में केवल सम्राट को ही बैंगनी पहनने की अनुमति थी! बैंगनी रंग समुद्री घोंघों से बनाया जाता था और केवल 1 ग्राम रंग बनाने के लिए 10,000 घोंघे लगते थे!"}'::jsonb,
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

INSERT INTO public.colors (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'pink',
  (SELECT id FROM categories WHERE category_key = 'colors' LIMIT 1),
  '{"en":"Pink","gu":"ગુલાબી","hi":"गुलाबी"}'::jsonb,
  'assets/images/colors/pink.png',
  '#E91E63',
  '{"en":"Pink! The sweet, soft color of flowers, candy, and flamingos!","gu":"ગુલાબી! ફૂલો, કેન્ડી અને ફ્લેમિંગો પક્ષીનો મીઠો અને કોમળ રંગ!","hi":"गुलाबी! फूलों, कैंडी और फ्लेमिंगो का प्यारा और कोमल रंग!"}'::jsonb,
  '{"en":"Pink is made by mixing red with white. We see it in flamingos, cherry blossoms, cotton candy, roses, and watermelon flesh. Pink is a tint of red, meaning it is red with white added to make it lighter and softer!","gu":"લાલ રંગમાં સફેદ રંગ મેળવવાથી ગુલાબી રંગ બને છે. આપણે તેને ફ્લેમિંગો પક્ષી, ચેરી બ્લોસમ, કોટન કેન્ડી, ગુલાબ અને તરબૂચમાં જોઈએ છીએ. ગુલાબી એ લાલ રંગનો જ એક હળવો ભાગ છે.","hi":"लाल रंग में सफेद मिलाने से गुलाबी रंग बनता है। हम इसे फ्लेमिंगो, चेरी ब्लॉसम, बुढ़िया के बाल (कॉटन कैंडी), गुलाब और तरबूज में देखते हैं। गुलाबी रंग लाल का ही एक हल्का रूप है।"}'::jsonb,
  '{"en":"Did you know? Flamingos are actually born white! They turn pink because of the pink algae and shrimps they eat. If they stopped eating pink food, they would turn white again!","gu":"શું તમે જાણો છો? ફ્લેમિંગો પક્ષીઓ વાસ્તવમાં સફેદ રંગના જન્મે છે! તેઓ જે ખોરાક ખાય છે તેના લીધે તેમનો રંગ ગુલાબી બને છે. જો તેઓ આ ખોરાક ખાવાનું બંધ કરી દે તો તેઓ ફરીથી સફેદ થઈ જાય!","hi":"क्या आपको पता है? फ्लेमिंगो वास्तव में सफेद पैदा होते हैं! वे जो गुलाबी शैवाल और झींगे खाते हैं, उसकी वजह से उनका रंग गुलाबी हो जाता है। यदि वे ऐसा खाना बंद कर दें, तो वे फिर से सफेद हो जाएंगे!"}'::jsonb,
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

INSERT INTO public.colors (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'brown',
  (SELECT id FROM categories WHERE category_key = 'colors' LIMIT 1),
  '{"en":"Brown","gu":"કથ્થઈ","hi":"भूरा"}'::jsonb,
  'assets/images/colors/brown.png',
  '#795548',
  '{"en":"Brown! The warm, earthy color of wood, soil, and chocolate!","gu":"કથ્થઈ! લાકડું, માટી અને ચોકલેટનો ગરમ અને કુદરતી રંગ!","hi":"भूरा! लकड़ी, मिट्टी और चॉकलेट का गर्म और प्राकृतिक रंग!"}'::jsonb,
  '{"en":"Brown is made by mixing red, yellow, and black (or mixing orange and black). We see brown in tree trunks, soil, teddy bears, chocolate, and wood furniture. Brown is the color of the earth itself — very common in nature!","gu":"લાલ, પીળો અને કાળો રંગ મેળવીને કથ્થઈ રંગ બનાવવામાં આવે છે. આપણે તેને વૃક્ષના થડ, માટી, ટેડી બેર, ચોકલેट અને લાકડાના ફર્નિચરમાં જોઈએ છીએ. કથ્થઈ એ આપણી ધરતીનો જ રંગ છે.","hi":"लाल, पीले और काले रंग को मिलाकर भूरा रंग बनाया जाता है। हम इसे पेड़ के तनों, मिट्टी, टेडी बियर, चॉकलेट और लकड़ी के फर्नीचर में देखते हैं। भूरा हमारी मिट्टी का ही रंग है जो प्रकृति में हर जगह मिलता है।"}'::jsonb,
  '{"en":"Did you know? Brown is actually the most common color on Earth — it is the color of most soils, rocks, and tree bark. Without brown, plants could not grow!","gu":"શું તમે જાણો છો? કથ્થઈ ખરેખર પૃથ્વી પરનો સૌથી સામાન્ય રંગ છે. તે મોટાભાગની માટી અને વૃક્ષોની છાલનો રંગ છે. માટી વગર વનસ્પતિ ઉગી શકે નહીં!","hi":"क्या आपको पता है? भूरा वास्तव में पृथ्वी पर सबसे आम रंगों में से एक है। यह अधिकांश मिट्टी, चट्टानों और पेड़ों की छाल का रंग है। मिट्टी के बिना पौधे नहीं उग सकते!"}'::jsonb,
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

INSERT INTO public.colors (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'black',
  (SELECT id FROM categories WHERE category_key = 'colors' LIMIT 1),
  '{"en":"Black","gu":"કાળો","hi":"काला"}'::jsonb,
  'assets/images/colors/black.png',
  '#212121',
  '{"en":"Black! The darkest color — the absence of all light!","gu":"કાળો! સૌથી ઘેરો રંગ, જ્યાં કોઈપણ પ્રકાશ હાજર હોતો નથી!","hi":"काला! सबसे गहरा रंग — जहां कोई प्रकाश नहीं होता!"}'::jsonb,
  '{"en":"Black absorbs all light — it reflects no color at all. We see black in night sky, coal, crows, piano keys, and tuxedos. Black is technically not a color but the absence of all visible light!","gu":"કાળો રંગ તમામ પ્રકાશને શોષી લે છે અને કોઈપણ રંગને પરાવર્તિત કરતો નથી. આપણે રાત્રિના આકાશ, કોલસો, કાગડો અને પિયાનોની કીમાં કાળો રંગ જોઈએ છીએ. વૈજ્ઞાનિક રીતે કાળો એ કોઈ રંગ નથી પરંતુ પ્રકાશની ગેરહાજરી છે.","hi":"काला रंग सभी प्रकाश को सोख लेता है और किसी भी रंग को परावर्तित नहीं करता। हम रात के आकाश, कोयले, कौवे और पियानो की कुंजियों में काला रंग देखते हैं। वैज्ञानिक रूप से काला कोई रंग नहीं बल्कि प्रकाश की अनुपस्थिति है।"}'::jsonb,
  '{"en":"Did you know? Black holes in space are black because not even light can escape them — they absorb everything, including light itself!","gu":"શું તમે જાણો છો? અવકાશમાં આવેલા બ્લેક હોલ એટલા માટે કાળા દેખાય છે કારણ કે તેમાંથી પ્રકાશ પણ બહાર નીકળી શકતો નથી, તે પ્રકાશને પણ શોષી લે છે!","hi":"क्या आपको पता है? अंतरिक्ष में ब्लैक होल काले होते हैं क्योंकि उनसे प्रकाश भी बाहर नहीं निकल पाता। वे प्रकाश सहित सब कुछ सोख लेते हैं!"}'::jsonb,
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

INSERT INTO public.colors (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'white',
  (SELECT id FROM categories WHERE category_key = 'colors' LIMIT 1),
  '{"en":"White","gu":"સફેદ","hi":"सफेद"}'::jsonb,
  'assets/images/colors/white.png',
  '#FAFAFA',
  '{"en":"White! The purest color — a mix of all the colors of light combined!","gu":"સફેદ! સૌથી શુદ્ધ રંગ, જે પ્રકાશના તમામ રંગોનું મિશ્રણ છે!","hi":"सफेद! सबसे शुद्ध रंग — जो प्रकाश के सभी रंगों का मिश्रण है!"}'::jsonb,
  '{"en":"White reflects all light — that is why it looks bright and pure. We see white in snow, clouds, milk, eggs, and daisies. In science, white is actually all the colors of the rainbow combined into one!","gu":"સફેદ રંગ તમામ પ્રકાશને પરાવર્તિત કરે છે, તેથી જ તે ખૂબ ચમકતો અને શુદ્ધ દેખાય છે. આપણે બરફ, વાદળો, દૂધ, ઈંડાં અને ફૂલોમાં સફેદ રંગ જોઈએ છીએ. વિજ્ઞાનમાં સફેદ એ મેઘધનુષના તમામ રંગોનું મિશ્રણ છે.","hi":"सफेद रंग सभी प्रकाश को परावर्तित करता है, इसलिए यह बहुत चमकीला और शुद्ध दिखता है। हम बर्फ, बादलों, दूध, अंडे और फूलों में सफेद रंग देखते हैं। विज्ञान में सफेद रंग वास्तव में इंद्रधनुष के सभी रंगों का मिश्रण है।"}'::jsonb,
  '{"en":"Did you know? When you use a prism to split white sunlight, you get all 7 colors of the rainbow! White light is actually a mixture of red, orange, yellow, green, blue, indigo, and violet!","gu":"શું તમે જાણો છો? જ્યારે તમે પ્રિઝમ દ્વારા સૂર્યપ્રકાશને વિભાજીત કરો છો ત્યારે મેઘધનુષના સાતેય રંગો જોવા મળે છે! સફેદ પ્રકાશ એ લાલ, લીલો, પીળો અને વાદળી સહિત તમામ રંગોનું મિશ્રણ છે.","hi":"क्या आपको पता है? जब आप एक प्रिज्म के माध्यम से सफेद धूप को गुजारते हैं, तो आपको इंद्रधनुष के सभी 7 रंग मिलते हैं! सफेद रोशनी वास्तव में सभी रंगों का मिश्रण है।"}'::jsonb,
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

INSERT INTO public.colors (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'gray',
  (SELECT id FROM categories WHERE category_key = 'colors' LIMIT 1),
  '{"en":"Gray","gu":"રાખોડી","hi":"ग्रे"}'::jsonb,
  'assets/images/colors/gray.png',
  '#9E9E9E',
  '{"en":"Gray! The calm, neutral color between black and white!","gu":"રાખોડી! કાળા અને સફેદ રંગ વચ્ચેનો એક શાંત અને તટસ્થ રંગ!","hi":"ग्रे! काले और सफेद के बीच का एक शांत और तटस्थ रंग!"}'::jsonb,
  '{"en":"Gray is made by mixing black and white. We see it in elephants, clouds, concrete, wolves, and rainy skies. Gray is a neutral color — it goes well with every other color and is often used in modern design and fashion!","gu":"કાળો અને સફેદ રંગ ભેગા કરવાથી રાખોડી રંગ બને છે. આપણે હાથી, વાદળો, સિમેન્ટની દીવાલો અને વરસાદી આકાશમાં રાખોડી રંગ જોઈએ છીએ. રાખોડી એ તટસ્થ રંગ છે અને તે ફેશનમાં ખૂબ જ લોકપ્રિય છે.","hi":"काले और सफेद को मिलाने से ग्रे (राखोडी) रंग बनता है। हम हाथियों, बादलों, सीमेंट और बरसाती आसमान में ग्रे रंग देखते हैं। ग्रे एक तटस्थ रंग है जो हर दूसरे रंग के साथ अच्छा लगता है।"}'::jsonb,
  '{"en":"Did you know? Elephants'' skin appears gray but it is actually covered in tiny hairs! These hairs help them trap moisture and stay cool in the hot African sun.","gu":"શું તમે જાણો છો? હાથીની ચામડી રાખોડી દેખાય છે પરંતુ તેના પર નાના વાળ હોય છે જે તેને ગરમીમાં ઠંડક આપવા માટે મદદરૂપ બને છે.","hi":"क्या आपको पता है? हाथियों की त्वचा ग्रे दिखती है लेकिन वास्तव में इस पर छोटे-छोटे बाल होते हैं। ये बाल उन्हें गर्म मौसम में ठंडा रखने में मदद करते हैं।"}'::jsonb,
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

INSERT INTO public.colors (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'gold',
  (SELECT id FROM categories WHERE category_key = 'colors' LIMIT 1),
  '{"en":"Gold","gu":"સોનેરી","hi":"सुनहरा"}'::jsonb,
  'assets/images/colors/gold.png',
  '#FFC107',
  '{"en":"Gold! The shiny, precious color of treasure and trophies!","gu":"સોનેરી! ખજાના અને વિજયી ટ્રોફીનો ચમકતો અને કિંમતી રંગ!","hi":"सुनहरा! खजाने और चमचमाती ट्रॉफी का कीमती रंग!"}'::jsonb,
  '{"en":"Gold is a warm, rich yellow color that resembles the precious metal gold. We see it in trophies, medals, wedding rings, sunsets, and crowns. Gold symbolizes wealth, success, and achievement across most cultures of the world!","gu":"સોનેરી એ કિંમતી ધાતુ સોના જેવો પીળો અને ચમકતો રંગ છે. આપણે તેને ટ્રોફી, મેડલ, સોનાની વીંટી, સૂર્યાસ્ત અને મુકુટમાં જોઈએ છીએ. સોનેરી રંગ સમૃદ્ધિ અને સફળતાનું પ્રતીક છે.","hi":"सुनहरा एक समृद्ध पीला रंग है जो सोने जैसी कीमती धातु जैसा दिखता है। हम इसे ट्रॉफी, पदक, सोने की अंगूठियों, सूर्यास्त और मुकुट में देखते हैं। यह रंग सफलता और समृद्धि को दर्शाता है।"}'::jsonb,
  '{"en":"Did you know? All the gold ever mined in human history would fit into just 3.5 Olympic-size swimming pools — it is incredibly rare!","gu":"શું તમે જાણો છો? માનવ ઇતિહાસમાં અત્યાર સુધી જેટલું પણ સોનું ખોદીને કાઢવામાં આવ્યું છે તે બધું જ માત્ર સાડા ત્રણ ઓલિમ્પિક સ્વિમિંગ પૂલમાં સમાઈ શકે છે! તે ખૂબ જ કિંમતી છે.","hi":"क्या आपको पता है? मानव इतिहास में अब तक खोजा गया सारा सोना केवल साढ़े तीन ओलंपिक स्विमिंग पूल में समा सकता है! यह बहुत ही दुर्लभ और कीमती है।"}'::jsonb,
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

INSERT INTO public.colors (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'silver',
  (SELECT id FROM categories WHERE category_key = 'colors' LIMIT 1),
  '{"en":"Silver","gu":"રૂપેરી","hi":"चांदी"}'::jsonb,
  'assets/images/colors/silver.png',
  '#E0E0E0',
  '{"en":"Silver! The cool, shiny metallic color of coins and mirrors!","gu":"રૂપેરી! સિક્કા અને અરીસા જેવો ઠંડો અને ચમકતો ધાતુનો રંગ!","hi":"चांदी! सिक्कों और दर्पणों का ठंडा और चमकदार धातुई रंग!"}'::jsonb,
  '{"en":"Silver is a shiny gray color that resembles the precious metal silver. We see it in coins, mirrors, spoons, cutlery, jewelry, and sports cars. Silver is often associated with the moon and with second place (silver medal)!","gu":"રૂપેરી એ ચાંદી ધાતુ જેવો જ ચમકતો રાખોડી રંગ છે. આપણે તેને સિક્કા, અરીસા, ચમચી, દાગીના અને સ્પોર્ટ્સ કારમાં જોઈએ છીએ. આ રંગ ચંદ્ર અને બીજા નંબરના ઇનામ (સિલ્વર મેડલ) સાથે જોડાયેલો છે.","hi":"चांदी जैसी धातु का रंग चमकीला ग्रे होता है। हम इसे सिक्कों, दर्पणों, चम्मचों, गहनों और शानदार कारों में देखते हैं। चांदी का रंग अक्सर चंद्रमा और खेल में दूसरे स्थान (रजत पदक) से जुड़ा होता है!"}'::jsonb,
  '{"en":"Did you know? Silver is the best conductor of electricity of all metals! That''s why silver is used inside touch screens — your finger conducts a tiny bit of silver''s signal!","gu":"શું તમે જાણો છો? ચાંદી એ વિદ્યુતનું સૌથી ઉત્તમ વાહક છે! તેથી જ ટચ સ્ક્રીનની અંદર પણ ચાંદીના ઝીણા તારનો ઉપયોગ થાય છે.","hi":"क्या आपको पता है? चांदी सभी धातुओं में बिजली का सबसे अच्छा सुचालक है! इसीलिए मोबाइल की टच स्क्रीन के अंदर इसका उपयोग किया जाता है।"}'::jsonb,
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

INSERT INTO public.colors (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'cyan',
  (SELECT id FROM categories WHERE category_key = 'colors' LIMIT 1),
  '{"en":"Cyan","gu":"મોરપીંછ","hi":"सायन"}'::jsonb,
  'assets/images/colors/cyan.png',
  '#00BCD4',
  '{"en":"Cyan! The bright aqua color between blue and green!","gu":"મોરપીંછ! વાદળી અને લીલા રંગ વચ્ચેનો પાણી જેવો સુંદર રંગ!","hi":"सायन! नीले और हरे रंग के बीच का चमकीला जलीय (एक्वा) रंग!"}'::jsonb,
  '{"en":"Cyan is made by mixing blue and green. It is a bright, refreshing color seen in tropical ocean water, butterflies, dragonflies, and swimming pools. Cyan is also one of the four colors used in color printing (CMYK)!","gu":"વાદળી અને લીલા રંગને મિશ્ર કરવાથી મોરપીંછ રંગ બને છે. તે સમુદ્રના પાણી, પતંગિયા અને સ્વિમિંગ પૂલમાં જોવા મળતો તાજગીસભર રંગ છે. પ્રિન્ટિંગમાં વપરાતા મુખ્ય ચાર રંગોમાં મોરપીંછ એક છે.","hi":"नीले और हरे रंग को मिलाकर सायन रंग बनता है। यह समुद्र के पानी, सुंदर तितलियों और स्विमिंग पूल में देखा जाने वाला एक ताज़ा रंग है। प्रिंटिंग में इस्तेमाल होने वाले मुख्य चार रंगों में से एक सायन भी है।"}'::jsonb,
  '{"en":"Did you know? Your printer uses cyan ink! Printers create all colors using just 4 inks: Cyan, Magenta, Yellow, and Black (CMYK). Combined, they can make millions of different colors!","gu":"શું તમે જાણો છો? તમારા પ્રિન્ટરમાં સાયન ઇંકનો ઉપયોગ થાય છે! પ્રિન્ટર માત્ર ૪ શાહી વડે લાખો રંગો બનાવી શકે છે: સયાન, મેજેન્ટા, પીળો અને કાળો રંગ.","hi":"क्या आपको पता है? आपके प्रिंटर में सायन रंग का उपयोग होता है! रंगीन प्रिंटर केवल 4 स्याही: सायन, मैजेंटा, पीला और काला (CMYK) का उपयोग करके लाखों रंग बना सकते हैं।"}'::jsonb,
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

INSERT INTO public.colors (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'lime',
  (SELECT id FROM categories WHERE category_key = 'colors' LIMIT 1),
  '{"en":"Lime","gu":"લીંબુ લીલો","hi":"नींबू हरा"}'::jsonb,
  'assets/images/colors/lime.png',
  '#8BC34A',
  '{"en":"Lime! The zesty, bright yellow-green color full of energy!","gu":"લીંબુ લીલો! ઉર્જાથી ભરેલો ખાટો-મીઠો પીળો-લીલો રંગ!","hi":"नींबू हरा! ऊर्जा से भरपूर खट्टा-मीठा पीला-हरा रंग!"}'::jsonb,
  '{"en":"Lime is a bright yellow-green color named after the lime fruit. We see it in lime fruits, fresh spring leaves, some frogs, and neon sports gear. Lime is one of the most visible colors — that is why safety vests are lime green!","gu":"લીંબુ લીલો એ લીંબુ જેવા ફળ પરથી નામ અપાયેલો પીળો-લીલો રંગ છે. આપણે તેને લીંબુ, વસંતના નવા પાંદડા, કેટલાક દેડકા અને રમતગમતના સાધનોમાં જોઈએ છીએ. તે ખૂબ જ તેજસ્વી હોવાથી સુરક્ષા જેકેટ પણ આ રંગના બનાવવામાં આવે છે.","hi":"नींबू हरा एक पीला-हरा रंग है जिसका नाम नींबू फल के नाम पर रखा गया है। हम इसे ताजे पत्तों, कुछ मेंढकों और खेल के कपड़ों में देखते हैं। यह रंग रात में भी चमकता है, इसलिए सुरक्षा जैकेट इस रंग की बनाई जाती हैं।"}'::jsonb,
  '{"en":"Did you know? Safety vests and construction workers'' jackets are lime green because this color is the most visible to the human eye in both daylight and low-light conditions!","gu":"શું તમે જાણો છો? સેફ્ટી જેકેટ અને રસ્તા પર કામ કરતા લોકોના કપડાં લીંબુ લીલા રંગના હોય છે, કારણ કે આ રંગ અંધારામાં પણ સૌથી વધુ ચમકે છે!","hi":"क्या आपको पता है? सुरक्षा जैकेट नींबू हरे रंग की होती हैं क्योंकि यह रंग दिन और रात दोनों समय इंसानी आंखों को सबसे आसानी से दिखाई देता है।"}'::jsonb,
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

INSERT INTO public.colors (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'navy',
  (SELECT id FROM categories WHERE category_key = 'colors' LIMIT 1),
  '{"en":"Navy","gu":"ઘેરો વાદળી","hi":"गहरा नीला"}'::jsonb,
  'assets/images/colors/navy.png',
  '#1A237E',
  '{"en":"Navy! The deep, dark blue color of the ocean depths and naval uniforms!","gu":"ઘેરો વાદળી! ઊંડા સમુદ્ર અને નેવી સૈનિકોના યુનિફોર્મનો સુંદર ઘેરો રંગ!","hi":"गहरा नीला! समुद्र की गहराई और नौसेना की वर्दी का गहरा रंग!"}'::jsonb,
  '{"en":"Navy blue is a very dark shade of blue, almost like the deep ocean. It was originally the color of British Royal Navy uniforms in the 1700s — that is how it got its name! We see navy in uniforms, suits, and denim jeans.","gu":"નેવી બ્લૂ એ વાદળી રંગનો ખૂબ જ ઘેરો ભાગ છે, જે લગભગ ઊંડા સમુદ્ર જેવો દેખાય છે. તે શરૂઆતમાં ૧૭૦૦ના દાયકામાં બ્રિટિશ નેવીની યુનિફોર્મનો રંગ હતો, જેના પરથી તેનું નામ પડ્યું. આપણે તેને યુનિફોર્મ અને જિન્સમાં જોઈએ છીએ.","hi":"नेवी ब्लू नीले रंग का एक बहुत ही गहरा रूप है, जो समुद्र की गहराई जैसा दिखता है। मूल रूप से 1700 के दशक में ब्रिटिश नौसेना की वर्दी के लिए इस रंग का उपयोग किया गया था, जिससे इसका नाम पड़ा।"}'::jsonb,
  '{"en":"Did you know? The deep ocean below 1,000 meters is completely dark — no sunlight reaches there! Deep-sea fish have adapted to live in total darkness, making ''navy'' a perfect name for their world.","gu":"શું તમે જાણો છો? ૧૦૦૦ મીટરથી ઊંડા સમુદ્રમાં બિલકુલ અંધારું હોય છે અને સૂર્યપ્રકાશ પહોંચતો નથી! ત્યાં રહેતી માછલીઓ સંપૂર્ણ અંધારામાં જીવવા ટેવાયેલી હોય છે.","hi":"क्या आपको पता है? समुद्र में 1000 मीटर से नीचे पूरी तरह अंधेरा होता है और वहां सूरज की रोशनी नहीं पहुंचती! वहां की मछलियां इसी अंधेरे में रहने की आदी होती हैं।"}'::jsonb,
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

INSERT INTO public.colors (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'maroon',
  (SELECT id FROM categories WHERE category_key = 'colors' LIMIT 1),
  '{"en":"Maroon","gu":"કથ્થઈ લાલ","hi":"मैरून"}'::jsonb,
  'assets/images/colors/maroon.png',
  '#800000',
  '{"en":"Maroon! The deep, rich dark red color — bold and sophisticated!","gu":"કથ્થઈ લાલ! એક સુંદર અને ઘેરો લાલ રંગ!","hi":"मैरून! एक गहरा, शानदार लाल रंग जो बहुत आकर्षक होता है!"}'::jsonb,
  '{"en":"Maroon is a dark brownish-red color. The word maroon comes from the French word ''marron'' meaning chestnut. We see it in red wine, autumn leaves turning dark, some roses, and school uniforms in many countries!","gu":"મરૂન અથવા કથ્થઈ લાલ એ ઘેરો લાલ રંગ છે. મરૂન શબ્દ ફ્રેન્ચ શબ્દ પરથી આવ્યો છે જેનો અર્થ ચેસ્ટનટ થાય છે. આપણે તેને પાનખરના પાંદડા, કેટલાક ગુલાબ અને શાળાના ગણવેશમાં જોઈએ છીએ.","hi":"मैरून एक गहरा भूरा-लाल रंग होता है। मैरून शब्द फ्रेंच शब्द मैरॉन से आया है जिसका अर्थ शाहबलूत (चेस्टनट) होता है। हम इसे गुलाब के फूलों और स्कूल के बच्चों के कपड़ों में देखते हैं।"}'::jsonb,
  '{"en":"Did you know? Maroon was once used as a signal for distress at sea — sailors would fire a maroon (a type of firework) to call for help when their ship was in danger!","gu":"શું તમે જાણો છો? એક સમયે દરિયામાં કોઈ જહાજ મુશ્કેલીમાં હોય ત્યારે મદદ મેળવવા માટે હવામાં મરૂન રંગના ફટાકડા ફોડીને સિગ્નલ આપવામાં આવતું હતું!","hi":"क्या आपको पता है? पुराने समय में समुद्र में संकट के समय मदद बुलाने के लिए मैरून रंग के पटाखों का उपयोग सिग्नलों के लिए किया जाता था!"}'::jsonb,
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

INSERT INTO public.colors (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'beige',
  (SELECT id FROM categories WHERE category_key = 'colors' LIMIT 1),
  '{"en":"Beige","gu":"બદામી","hi":"बेज"}'::jsonb,
  'assets/images/colors/beige.png',
  '#F5F5DC',
  '{"en":"Beige! The soft, warm neutral color — gentle and calming!","gu":"બદામી! ક્રીમ અને માટી જેવો હળવો અને શાંતદાયક રંગ!","hi":"बेज! एक हल्का और कोमल रंग जो आंखों को शांत करता है!"}'::jsonb,
  '{"en":"Beige is a pale sandy color somewhere between white and light brown. It is named after the French word for undyed wool. We see it in sand, linen fabric, sun hats, and wooden furniture. Beige is a very calming, natural color!","gu":"બેજ એ સફેદ અને હળવા કથ્થઈ રંગ વચ્ચેનો રેતી જેવો રંગ છે. તેનું નામ વણાયેલા કાચા ઊન પરથી પડ્યું છે. આપણે તેને દરિયાની રેતી, ટોપીઓ અને ફર્નિચરમાં જોઈએ છીએ. તે ખૂબ જ શાંત અને કુદરતી રંગ છે.","hi":"बेज सफेद और हल्के भूरे रंग के बीच का एक हल्का रेतीला रंग है। इसका नाम बिना रंगे ऊन के नाम पर रखा गया है। हम इसे रेत, लिनन के कपड़ों और लकड़ी के फर्नीचर में देखते हैं।"}'::jsonb,
  '{"en":"Did you know? Desert sand appears beige because of tiny minerals in the grains. In some deserts like the Sahara, the sand can shift from beige to orange and red depending on the angle of the sun!","gu":"શું તમે જાણો છો? રણની રેતી તેના ખનીજોના કારણે બદામી રંગની દેખાય છે. સૂર્યપ્રકાશના કિરણો બદલાતા તે નારંગી કે લાલ રંગ જેવી પણ દેખાઈ શકે છે.","hi":"क्या आपको पता है? रेगिस्तान की रेत खनिजों के कारण बेज रंग की दिखती है। सूर्य की किरणों के कोण बदलने पर रेत का रंग नारंगी या लाल भी दिख सकता है।"}'::jsonb,
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

INSERT INTO public.colors (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'turquoise',
  (SELECT id FROM categories WHERE category_key = 'colors' LIMIT 1),
  '{"en":"Turquoise","gu":"ફિરોઝી","hi":"फ़िरोज़ी"}'::jsonb,
  'assets/images/colors/turquoise.png',
  '#40E0D0',
  '{"en":"Turquoise! The beautiful blue-green color of tropical ocean water and gemstones!","gu":"ફિરોઝી! દરિયાના પાણી અને રત્નો જેવો અત્યંત સુંદર લીલો-વાદળી રંગ!","hi":"फ़िरोज़ी! समुद्र के साफ पानी और कीमती रत्नों जैसा सुंदर नीला-हरा रंग!"}'::jsonb,
  '{"en":"Turquoise is a blue-green color named after the turquoise gemstone, which comes from Turkey. We see it in shallow tropical sea water, peacock feathers, swimming pools, and the gemstone itself. It is one of the oldest known colors used by humans!","gu":"ફિરોઝી એ વાદળી-લીલો રંગ છે જે ફિરોઝા રત્ન પરથી નામ મેળવે છે. આપણે તેને મોરના પીંછા, દરિયા કિનારાના પાણી અને ઘરેણાંના રત્નમાં જોઈએ છીએ. તે મનુષ્યો દ્વારા વપરાતો સૌથી જૂનો જાણીતો રંગ છે.","hi":"फ़िरोज़ी एक नीला-हरा रंग है जिसका नाम फ़िरोज़ा रत्न के नाम पर रखा गया है। हम इसे मोर के सुंदर पंखों, साफ पानी और गहनों के रत्न में देखते हैं। यह मनुष्यों द्वारा उपयोग किए जाने वाले सबसे पुराने रंगों में से एक है।"}'::jsonb,
  '{"en":"Did you know? Turquoise is one of the first gemstones ever mined by humans — ancient Egyptians used turquoise in jewelry and amulets over 6,000 years ago!","gu":"શું તમે જાણો છો? મનુષ્ય દ્વારા જે પ્રથમ કિંમતી રત્ન ખોદકામ કરીને મેળવવામાં આવ્યા હતા તેમાં ફિરોઝા મુખ્ય છે. ઇજિપ્તવાસીઓ ૬૦૦૦ વર્ષ પહેલાં પણ ફિરોઝી ઘરેણાં પહેરતા હતા.","hi":"क्या आपको पता है? फ़िरोज़ा मनुष्यों द्वारा खोदे गए पहले रत्नों में से एक है। मिस्र के लोग 6,000 साल पहले भी फ़िरोज़ी आभूषणों का उपयोग करते थे!"}'::jsonb,
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
