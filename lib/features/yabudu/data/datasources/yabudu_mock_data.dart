import '../models/event_author_model.dart';
import '../models/event_item_model.dart';
import '../models/filter_option_model.dart';

class YabuduMockData {
  static const filters = <FilterOptionModel>[
    FilterOptionModel(id: 'fav', label: 'Избранные'),
    FilterOptionModel(id: 'date', label: 'Дата', hasArrow: true),
    FilterOptionModel(id: 'type', label: 'Тип событий', hasArrow: true),
  ];

  static const authorA = EventAuthorModel(
    id: 'a1',
    name: 'Анна',
    avatarUrl:
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200',
  );

  static const authorB = EventAuthorModel(
    id: 'a2',
    name: 'Илья',
    avatarUrl:
        'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200',
  );

  static const authorC = EventAuthorModel(
    id: 'a3',
    name: 'Мария',
    avatarUrl:
        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200',
  );

  static const nearbyEvents = <EventItemModel>[
    EventItemModel(
      id: '1',
      title: 'Керамический мастер-класс',
      dateLabel: '17 июля, 19:00',
      district: 'Сыромятнический переулок',
      imageUrl:
          'https://images.unsplash.com/photo-1513475382585-d06e58bcb0e0?w=800',
      priceLabel: '500 ₽',
      likes: 30,
      isFavorite: true,
      tag: EventTag.paid,
      author: authorA,
    ),
    EventItemModel(
      id: '2',
      title: 'Киновечер',
      dateLabel: '17 июля, 19:00',
      district: 'Сретенка, 700',
      imageUrl:
          'https://images.unsplash.com/photo-1497032205916-ac775f0649ae?w=800',
      priceLabel: '500 ₽',
      likes: 12,
      isFavorite: true,
      tag: EventTag.paid,
      author: authorB,
    ),
    EventItemModel(
      id: '3',
      title: 'Бесплатный мастер-класс',
      dateLabel: '17 июля, 19:00',
      district: 'Сретенка, 700',
      imageUrl:
          'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=800',
      priceLabel: 'Бесплатно',
      likes: 10,
      isFavorite: true,
      tag: EventTag.free,
      author: authorC,
    ),
    EventItemModel(
      id: '4',
      title: 'Арт-встреча',
      dateLabel: '18 июля, 19:00',
      district: 'Сретенка, 700',
      imageUrl:
          'https://images.unsplash.com/photo-1452587925148-ce544e77e70d?w=800',
      priceLabel: '500 - 2000 ₽',
      likes: 8,
      isFavorite: true,
      tag: EventTag.paid,
      author: authorA,
    ),
  ];

  static const recommendedEvents = <EventItemModel>[
    EventItemModel(
      id: 'r1',
      title: 'Шахматы',
      dateLabel: '15 июля, 19:00',
      district: 'Сыромятнический переулок',
      imageUrl:
          'https://images.unsplash.com/photo-1586165368502-1bad197a6461?w=1400',
      priceLabel: '500 ₽',
      likes: 36,
      isFavorite: true,
      tag: EventTag.paid,
      author: authorA,
    ),
    EventItemModel(
      id: 'r2',
      title: 'Ночной кинопоказ',
      dateLabel: '16 июля, 21:00',
      district: 'Хохловский переулок',
      imageUrl:
          'https://images.unsplash.com/photo-1489599735734-79b4ee1b88b9?w=1400',
      priceLabel: '700 ₽',
      likes: 22,
      isFavorite: false,
      tag: EventTag.paid,
      author: authorB,
    ),
    EventItemModel(
      id: 'r3',
      title: 'Литературный вечер',
      dateLabel: '19 июля, 18:30',
      district: 'Чистопрудный бульвар',
      imageUrl:
          'https://images.unsplash.com/photo-1495446815901-a7297e633e8d?w=1400',
      priceLabel: 'Бесплатно',
      likes: 18,
      isFavorite: true,
      tag: EventTag.free,
      author: authorC,
    ),
  ];

  static const popularEvents = nearbyEvents;

  static List<EventItemModel>? nearby;
}
