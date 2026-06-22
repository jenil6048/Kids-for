import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  test('Sync cover images from Supabase Storage to categories table', () async {
    print('Initializing Supabase client with EmptyLocalStorage...');
    
    await Supabase.initialize(
      url: 'https://pdhqylmzjdkvdbnezwhq.supabase.co',
      anonKey: 'sb_publishable_SizQcYl-aGVb-E1ormaC7Q_9gtGL6WU',
    );

    final client = Supabase.instance.client;

    try {
      // 1. Sync Groups First to prevent foreign key errors
      print('Upserting groups into "groups" table...');
      final List<Map<String, dynamic>> groups = [
        {
          'id': 'early_learning',
          'name': {'en': 'Early Learning', 'gu': 'પ્રારંભિક શિક્ષણ', 'hi': 'प्रारंभिक शिक्षा'},
          'icon': 'https://assets5.lottiefiles.com/packages/lf20_wd1udjcz.json'
        },
        {
          'id': 'natures_world',
          'name': {'en': "Nature's World", 'gu': 'કુદરતની દુનિયા', 'hi': 'कुदरत की दुनिया'},
          'icon': 'https://assets8.lottiefiles.com/packages/lf20_jcik4vlx.json'
        },
        {
          'id': 'brain_and_skill',
          'name': {'en': 'Brain & Skill', 'gu': 'મગજ અને કૌશલ્ય', 'hi': 'मस्तिष्क और कौशल'},
          'icon': 'https://assets5.lottiefiles.com/packages/lf20_qp1a7a00.json'
        },
        {
          'id': 'fun',
          'name': {'en': 'Fun Zone', 'gu': 'મનોરંજન ઝોન', 'hi': 'मनोरंजन क्षेत्र'},
          'icon': 'https://assets5.lottiefiles.com/packages/lf20_d1rjgkfn.json'
        },
        {
          'id': 'world_around_us',
          'name': {'en': 'World Around Us', 'gu': 'આપણી આસપાસની દુનિયા', 'hi': 'हमारी आसपास की दुनिया'},
          'icon': 'https://assets3.lottiefiles.com/packages/lf20_3rw9b9fn.json'
        }
      ];

      for (var grp in groups) {
        await client.from('groups').upsert(grp);
        print('✅ Upserted group: ${grp['id']}');
      }

      print('Groups syncing complete.\n');

      // 2. Sync Categories with public storage covers mapping
      print('Upserting categories into "categories" table...');
      final Map<String, String> keyToImageMap = {
        'alphabet': 'alphabet.png',
        'colors': 'color.png',
        'numbers': 'numbers.png',
        'shapes': 'shapes.png',
        'animals': 'animals.png',
        'sports': 'sports.png',
        'vehicles': 'vehicles.png',
        'nature': 'bird.png', // bird.png represents nature/animals in the bucket
        'space': 'space.png',
        'countries': 'countries.png',
        'science': 'science.png',
      };

      final List<Map<String, dynamic>> categoriesData = [
        {
          'id': 1,
          'category_key': 'alphabet',
          'title': {'en': 'Alphabet', 'gu': 'અક્ષરમાળા', 'hi': 'वर्णमाला'},
          'color': '#FFC107',
          'is_premium': false,
          'group_id': 'early_learning',
          'display_order': 1,
        },
        {
          'id': 2,
          'category_key': 'colors',
          'title': {'en': 'Colors', 'gu': 'રંગો', 'hi': 'रंग'},
          'color': '#E91E63',
          'is_premium': false,
          'group_id': 'early_learning',
          'display_order': 2,
        },
        {
          'id': 3,
          'category_key': 'numbers',
          'title': {'en': 'Numbers', 'gu': 'સંખ્યાઓ', 'hi': 'संख्याएँ'},
          'color': '#FF5722',
          'is_premium': false,
          'group_id': 'early_learning',
          'display_order': 3,
        },
        {
          'id': 4,
          'category_key': 'shapes',
          'title': {'en': 'Shapes', 'gu': 'આકારો', 'hi': 'આકાર'},
          'color': '#00BCD4',
          'is_premium': false,
          'group_id': 'early_learning',
          'display_order': 4,
        },
        {
          'id': 5,
          'category_key': 'animals',
          'title': {'en': 'Animals', 'gu': 'પ્રાણીઓ', 'hi': 'जानवर'},
          'color': '#4CAF50',
          'is_premium': false,
          'group_id': 'natures_world',
          'display_order': 5,
        },
        {
          'id': 6,
          'category_key': 'occupations',
          'title': {'en': 'Occupations', 'gu': 'વ્યવસાયો', 'hi': 'व्यवसाय'},
          'color': '#009688',
          'is_premium': false,
          'group_id': 'brain_and_skill',
          'display_order': 6,
        },
        {
          'id': 7,
          'category_key': 'sports',
          'title': {'en': 'Sports', 'gu': 'રમતો', 'hi': 'खेल'},
          'color': '#2196F3',
          'is_premium': false,
          'group_id': 'fun',
          'display_order': 7,
        },
        {
          'id': 8,
          'category_key': 'vehicles',
          'title': {'en': 'Vehicles', 'gu': 'વાહનો', 'hi': 'વાહન'},
          'color': '#9C27B0',
          'is_premium': false,
          'group_id': 'fun',
          'display_order': 8,
        },
        {
          'id': 9,
          'category_key': 'nature',
          'title': {'en': 'Nature', 'gu': 'કુદરત (પ્રકૃતિ)', 'hi': 'प्रकृति'},
          'color': '#607D8B',
          'is_premium': false,
          'group_id': 'natures_world',
          'display_order': 9,
        },
        {
          'id': 10,
          'category_key': 'space',
          'title': {'en': 'Space', 'gu': 'અવકાશ', 'hi': 'अंतरिक्ष'},
          'color': '#3F51B5',
          'is_premium': false,
          'group_id': 'world_around_us',
          'display_order': 10,
        },
        {
          'id': 11,
          'category_key': 'countries',
          'title': {'en': 'Countries & Cultures', 'gu': 'દેશો અને સંસ્કૃતિ', 'hi': 'દેશ ઔર સંસ્કૃતિ'},
          'color': '#FF5722',
          'is_premium': false,
          'group_id': 'world_around_us',
          'display_order': 11,
        },
        {
          'id': 12,
          'category_key': 'country_flags',
          'title': {'en': 'Country Flags', 'gu': 'દેશોના ધ્વજ', 'hi': 'દેશોં કે ઝંડે'},
          'color': '#3F51B5',
          'is_premium': false,
          'group_id': 'world_around_us',
          'display_order': 12,
        },
        {
          'id': 13,
          'category_key': 'science',
          'title': {'en': 'Science & Discovery', 'gu': 'વિજ્ઞાન અને શોધ', 'hi': 'વિજ્ઞાન ઔર ખોજ'},
          'color': '#E91E63',
          'is_premium': false,
          'group_id': 'brain_and_skill',
          'display_order': 13,
        },
        {
          'id': 14,
          'category_key': 'months',
          'title': {'en': 'Months', 'gu': 'મહિના', 'hi': 'મહીને'},
          'color': '#5C6BC0',
          'is_premium': false,
          'group_id': 'early_learning',
          'display_order': 14,
        },
      ];

      for (var cat in categoriesData) {
        final categoryKey = cat['category_key'] as String;
        final imageName = keyToImageMap[categoryKey];
        if (imageName != null) {
          cat['image_path'] = 'https://pdhqylmzjdkvdbnezwhq.supabase.co/storage/v1/object/public/assets/covers/$imageName';
        } else {
          cat['image_path'] = null;
        }
        cat['lottie_path'] = null;

        await client.from('categories').upsert(cat);
        print('✅ Upserted category: "${cat['category_key']}" (ID: ${cat['id']})');
      }

      print('Categories sync completed successfully!');
    } catch (e) {
      print('Error during sync: $e');
    }
  });
}
