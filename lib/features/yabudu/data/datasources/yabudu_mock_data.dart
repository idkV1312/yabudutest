import '../models/event_author_model.dart';
import '../models/event_item_model.dart';
import '../models/filter_option_model.dart';

class YabuduMockData {
  static const filters = <FilterOptionModel>[
    FilterOptionModel(id: 'fav', label: 'Избранные'),
    FilterOptionModel(id: 'date', label: 'Дата', hasArrow: true),
    FilterOptionModel(id: 'type', label: 'Тип события', hasArrow: true),
    FilterOptionModel(id: 'price', label: 'Цена', hasArrow: true),
    FilterOptionModel(id: 'geo', label: 'Геолокация', hasArrow: true),
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

  static const nearbyEvents = <EventItemModel>[
    EventItemModel(
      id: '1',
      title: 'Керамический мастер-класс',
      dateLabel: '17 — 19 августа 2025',
      district: 'Сыромятнический переулок',
      imageUrl:
          'https://images.unsplash.com/photo-1610701596007-11502861dcfa?w=800',
      priceLabel: '500 ₽',
      likes: 30,
      isFavorite: true,
      tag: EventTag.paid,
      author: authorA,
    ),
    EventItemModel(
      id: '2',
      title: 'Бесплатный мастер-класс',
      dateLabel: '15 июля, 19:00',
      district: 'Сыромятнический переулок',
      imageUrl:
          'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=800',
      priceLabel: 'Бесплатно',
      likes: 12,
      isFavorite: true,
      tag: EventTag.free,
      author: authorB,
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
      title: 'Кинопоказ',
      dateLabel: '16 июля, 21:00',
      district: 'Сыромятнический переулок',
      imageUrl:
          'https://images.unsplash.com/photo-1489599735734-79b4ee1b88b9?w=1400',
      priceLabel: '700 ₽',
      likes: 22,
      isFavorite: false,
      tag: EventTag.paid,
      author: authorB,
    ),
  ];

  static const popularEvents = nearbyEvents;

  static List<EventItemModel>? nearby;
}
