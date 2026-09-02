import 'package:flutter/material.dart';

import '../models/booking_model.dart';
import '../models/category_model.dart';
import '../models/chat_model.dart';
import '../models/notification_model.dart';
import '../models/provider_model.dart';
import '../models/review_model.dart';
import '../models/service_model.dart';
import '../models/user_model.dart';

/// Static, in-memory mock data set used across the whole app until a real
/// backend is wired up. Every feature controller reads from here.
class MockData {
  MockData._();

  static final UserModel currentUser = const UserModel(
    id: 'u1',
    name: 'Alex Morgan',
    email: 'alex.morgan@example.com',
    phone: '+1 415 555 0132',
    avatarSeed: 12,
    address: '221 Baker Street, San Francisco, CA',
  );

  static final List<CategoryModel> categories = [
    const CategoryModel(id: 'c1', name: 'Cleaning', icon: Icons.cleaning_services_rounded, colorIndex: 0, serviceCount: 48),
    const CategoryModel(id: 'c2', name: 'Plumbing', icon: Icons.plumbing_rounded, colorIndex: 1, serviceCount: 32),
    const CategoryModel(id: 'c3', name: 'Electrical', icon: Icons.electrical_services_rounded, colorIndex: 2, serviceCount: 27),
    const CategoryModel(id: 'c4', name: 'Photography', icon: Icons.camera_alt_rounded, colorIndex: 3, serviceCount: 19),
    const CategoryModel(id: 'c5', name: 'Tutoring', icon: Icons.school_rounded, colorIndex: 4, serviceCount: 41),
    const CategoryModel(id: 'c6', name: 'Beauty', icon: Icons.face_retouching_natural_rounded, colorIndex: 5, serviceCount: 36),
    const CategoryModel(id: 'c7', name: 'Car Repair', icon: Icons.car_repair_rounded, colorIndex: 6, serviceCount: 22),
    const CategoryModel(id: 'c8', name: 'Painting', icon: Icons.format_paint_rounded, colorIndex: 7, serviceCount: 15),
  ];

  static final List<ProviderModel> providers = [
    const ProviderModel(
      id: 'p1', name: 'Sarah Johnson', avatarSeed: 47, profession: 'Home Cleaning Specialist',
      rating: 4.9, reviewCount: 214, yearsExperience: 6, completedJobs: 512, isVerified: true, isOnline: true,
      location: 'San Francisco, CA', responseTime: 'Replies in ~10 min',
      bio: 'Detail-obsessed cleaner with 6 years of experience helping busy families and offices stay spotless. Eco-friendly products on request.',
      serviceIds: ['s1', 's2'], gallerySeeds: ['clean1', 'clean2', 'clean3', 'clean4'],
    ),
    const ProviderModel(
      id: 'p2', name: 'Mike Rodriguez', avatarSeed: 33, profession: 'Licensed Plumber',
      rating: 4.8, reviewCount: 156, yearsExperience: 9, completedJobs: 389, isVerified: true, isOnline: false,
      location: 'Oakland, CA', responseTime: 'Replies in ~30 min',
      bio: 'Licensed plumber handling everything from leaky faucets to full repipes. Upfront pricing, no surprises.',
      serviceIds: ['s3', 's4'], gallerySeeds: ['plumb1', 'plumb2', 'plumb3'],
    ),
    const ProviderModel(
      id: 'p3', name: 'David Chen', avatarSeed: 15, profession: 'Master Electrician',
      rating: 4.95, reviewCount: 302, yearsExperience: 12, completedJobs: 740, isVerified: true, isOnline: true,
      location: 'San Jose, CA', responseTime: 'Replies in ~5 min',
      bio: 'Master electrician specializing in panel upgrades, smart-home wiring and emergency repairs.',
      serviceIds: ['s5', 's6'], gallerySeeds: ['elec1', 'elec2', 'elec3', 'elec4'],
    ),
    const ProviderModel(
      id: 'p4', name: 'Emma Wilson', avatarSeed: 29, profession: 'Portrait & Event Photographer',
      rating: 4.9, reviewCount: 178, yearsExperience: 7, completedJobs: 265, isVerified: true, isOnline: true,
      location: 'San Francisco, CA', responseTime: 'Replies in ~15 min',
      bio: 'Capturing candid, warm moments for weddings, portraits and brand shoots for over 7 years.',
      serviceIds: ['s7', 's8'], gallerySeeds: ['photo1', 'photo2', 'photo3', 'photo4'],
    ),
    const ProviderModel(
      id: 'p5', name: 'James Anderson', avatarSeed: 52, profession: 'Math & Physics Tutor',
      rating: 4.85, reviewCount: 124, yearsExperience: 5, completedJobs: 410, isVerified: true, isOnline: false,
      location: 'Berkeley, CA', responseTime: 'Replies in ~20 min',
      bio: 'Former high-school teacher turned private tutor. Specializing in exam prep for middle and high schoolers.',
      serviceIds: ['s9'], gallerySeeds: ['tutor1', 'tutor2'],
    ),
    const ProviderModel(
      id: 'p6', name: 'Sophia Martinez', avatarSeed: 21, profession: 'Makeup & Hair Stylist',
      rating: 4.92, reviewCount: 251, yearsExperience: 8, completedJobs: 601, isVerified: true, isOnline: true,
      location: 'San Francisco, CA', responseTime: 'Replies in ~10 min',
      bio: 'Bridal and editorial makeup artist. Mobile service — I come to you with a full kit.',
      serviceIds: ['s10', 's11'], gallerySeeds: ['beauty1', 'beauty2', 'beauty3'],
    ),
    const ProviderModel(
      id: 'p7', name: 'Robert Taylor', avatarSeed: 8, profession: 'Auto Mechanic',
      rating: 4.7, reviewCount: 98, yearsExperience: 11, completedJobs: 320, isVerified: false, isOnline: true,
      location: 'Fremont, CA', responseTime: 'Replies in ~40 min',
      bio: 'Mobile mechanic offering diagnostics, brake service and oil changes at your driveway.',
      serviceIds: ['s12'], gallerySeeds: ['car1', 'car2'],
    ),
    const ProviderModel(
      id: 'p8', name: 'Linda Park', avatarSeed: 44, profession: 'Interior & Exterior Painter',
      rating: 4.88, reviewCount: 143, yearsExperience: 10, completedJobs: 275, isVerified: true, isOnline: false,
      location: 'Palo Alto, CA', responseTime: 'Replies in ~25 min',
      bio: 'Precision painting for homes and offices. Free color consultation with every quote.',
      serviceIds: ['s13'], gallerySeeds: ['paint1', 'paint2', 'paint3'],
    ),
  ];

  static final List<ServiceModel> services = [
    const ServiceModel(id: 's1', title: 'Deep Home Cleaning', categoryId: 'c1', categoryName: 'Cleaning', providerId: 'p1', price: 45, priceUnit: PriceUnit.hour, rating: 4.9, reviewCount: 214, imageSeed: 'svc-clean-1', description: 'A thorough top-to-bottom clean covering kitchens, bathrooms, floors and hard-to-reach corners. Bring your own supplies or request eco-friendly products.', tags: ['Eco-friendly', 'Insured', 'Same-day'], duration: '2-3 hrs', location: 'San Francisco, CA', isPopular: true),
    const ServiceModel(id: 's2', title: 'Move-in / Move-out Cleaning', categoryId: 'c1', categoryName: 'Cleaning', providerId: 'p1', price: 120, priceUnit: PriceUnit.fixed, rating: 4.8, reviewCount: 98, imageSeed: 'svc-clean-2', description: 'End-of-lease clean that meets landlord checklists — appliances, cabinets, baseboards included.', tags: ['Checklist included', 'Insured'], duration: '4 hrs', location: 'San Francisco, CA'),
    const ServiceModel(id: 's3', title: 'Leak Detection & Repair', categoryId: 'c2', categoryName: 'Plumbing', providerId: 'p2', price: 65, priceUnit: PriceUnit.hour, rating: 4.8, reviewCount: 156, imageSeed: 'svc-plumb-1', description: 'Fast diagnosis and repair for leaking pipes, faucets and water heaters.', tags: ['Emergency', 'Licensed'], duration: '1-2 hrs', location: 'Oakland, CA', isPopular: true),
    const ServiceModel(id: 's4', title: 'Drain & Pipe Unclogging', categoryId: 'c2', categoryName: 'Plumbing', providerId: 'p2', price: 55, priceUnit: PriceUnit.visit, rating: 4.7, reviewCount: 87, imageSeed: 'svc-plumb-2', description: 'Clear stubborn clogs in sinks, showers and main lines using professional-grade equipment.', tags: ['Licensed'], duration: '1 hr', location: 'Oakland, CA'),
    const ServiceModel(id: 's5', title: 'Electrical Panel Upgrade', categoryId: 'c3', categoryName: 'Electrical', providerId: 'p3', price: 350, priceUnit: PriceUnit.fixed, rating: 4.95, reviewCount: 302, imageSeed: 'svc-elec-1', description: 'Upgrade your home to a modern breaker panel to safely support today\'s power demands.', tags: ['Licensed', 'Permitted'], duration: '3-5 hrs', location: 'San Jose, CA', isPopular: true),
    const ServiceModel(id: 's6', title: 'Smart Home Wiring', categoryId: 'c3', categoryName: 'Electrical', providerId: 'p3', price: 80, priceUnit: PriceUnit.hour, rating: 4.9, reviewCount: 121, imageSeed: 'svc-elec-2', description: 'Wiring and setup for smart switches, thermostats and lighting systems.', tags: ['Licensed'], duration: '2 hrs', location: 'San Jose, CA'),
    const ServiceModel(id: 's7', title: 'Portrait Photoshoot', categoryId: 'c4', categoryName: 'Photography', providerId: 'p4', price: 150, priceUnit: PriceUnit.fixed, rating: 4.9, reviewCount: 178, imageSeed: 'svc-photo-1', description: 'One-hour outdoor or studio portrait session with 20 edited digital photos.', tags: ['20 photos included', 'Same-week delivery'], duration: '1 hr', location: 'San Francisco, CA', isPopular: true),
    const ServiceModel(id: 's8', title: 'Event Photography', categoryId: 'c4', categoryName: 'Photography', providerId: 'p4', price: 95, priceUnit: PriceUnit.hour, rating: 4.85, reviewCount: 64, imageSeed: 'svc-photo-2', description: 'Full event coverage for parties, corporate events and small weddings.', tags: ['Full-day available'], duration: 'Flexible', location: 'San Francisco, CA'),
    const ServiceModel(id: 's9', title: 'Math & Physics Tutoring', categoryId: 'c5', categoryName: 'Tutoring', providerId: 'p5', price: 40, priceUnit: PriceUnit.hour, rating: 4.85, reviewCount: 124, imageSeed: 'svc-tutor-1', description: 'One-on-one tutoring for algebra, calculus and physics, tailored to your curriculum.', tags: ['Online or in-person'], duration: '1 hr', location: 'Berkeley, CA', isPopular: true),
    const ServiceModel(id: 's10', title: 'Bridal Makeup', categoryId: 'c6', categoryName: 'Beauty', providerId: 'p6', price: 180, priceUnit: PriceUnit.fixed, rating: 4.92, reviewCount: 251, imageSeed: 'svc-beauty-1', description: 'Full bridal glam including trial session, long-wear makeup and touch-up kit.', tags: ['Mobile', 'Trial included'], duration: '2 hrs', location: 'San Francisco, CA', isPopular: true),
    const ServiceModel(id: 's11', title: 'Haircut & Styling', categoryId: 'c6', categoryName: 'Beauty', providerId: 'p6', price: 60, priceUnit: PriceUnit.fixed, rating: 4.8, reviewCount: 132, imageSeed: 'svc-beauty-2', description: 'Precision haircut and blow-dry styling at your home.', tags: ['Mobile'], duration: '45 min', location: 'San Francisco, CA'),
    const ServiceModel(id: 's12', title: 'Mobile Oil Change & Diagnostics', categoryId: 'c7', categoryName: 'Car Repair', providerId: 'p7', price: 70, priceUnit: PriceUnit.fixed, rating: 4.7, reviewCount: 98, imageSeed: 'svc-car-1', description: 'Full synthetic oil change and 21-point diagnostic check at your driveway.', tags: ['Mobile', 'Same-day'], duration: '45 min', location: 'Fremont, CA'),
    const ServiceModel(id: 's13', title: 'Interior Wall Painting', categoryId: 'c8', categoryName: 'Painting', providerId: 'p8', price: 3, priceUnit: PriceUnit.fixed, rating: 4.88, reviewCount: 143, imageSeed: 'svc-paint-1', description: 'Clean, precise interior painting priced per square foot with free color consultation.', tags: ['Free consultation'], duration: '1-2 days', location: 'Palo Alto, CA', isPopular: true),
  ];

  static final List<ReviewModel> reviews = [
    ReviewModel(id: 'r1', userName: 'Jessica Lee', avatarSeed: 5, rating: 5, comment: 'Sarah was fantastic — showed up early and the apartment has never looked cleaner. Booking again next month.', date: DateTime(2026, 8, 20), serviceId: 's1', providerId: 'p1'),
    ReviewModel(id: 'r2', userName: 'Tom Becker', avatarSeed: 61, rating: 4.5, comment: 'Great attention to detail, just wish there were more availability slots on weekends.', date: DateTime(2026, 8, 12), serviceId: 's1', providerId: 'p1'),
    ReviewModel(id: 'r3', userName: 'Priya Nair', avatarSeed: 23, rating: 5, comment: 'Mike fixed a leak we\'d been dealing with for weeks in under an hour. Fair pricing too.', date: DateTime(2026, 8, 18), serviceId: 's3', providerId: 'p2'),
    ReviewModel(id: 'r4', userName: 'Carlos Mendez', avatarSeed: 39, rating: 5, comment: 'David is incredibly knowledgeable, explained everything before starting. Highly recommend.', date: DateTime(2026, 7, 29), serviceId: 's5', providerId: 'p3'),
    ReviewModel(id: 'r5', userName: 'Hannah Kim', avatarSeed: 18, rating: 4.8, comment: 'Emma made the shoot so easy and fun, photos turned out beautiful!', date: DateTime(2026, 8, 3), serviceId: 's7', providerId: 'p4'),
    ReviewModel(id: 'r6', userName: 'Daniel Osei', avatarSeed: 71, rating: 4.6, comment: 'My son\'s grades improved within a month of tutoring with James. Patient and clear explanations.', date: DateTime(2026, 7, 15), serviceId: 's9', providerId: 'p5'),
  ];

  static final List<BookingModel> bookings = [
    BookingModel(id: 'b1', serviceId: 's1', serviceTitle: 'Deep Home Cleaning', categoryName: 'Cleaning', providerId: 'p1', providerName: 'Sarah Johnson', providerAvatarSeed: 47, date: DateTime(2026, 9, 5), time: '10:00 AM', address: '221 Baker Street, San Francisco, CA', price: 90, status: BookingStatus.upcoming, paymentMethod: 'Visa •••• 4291'),
    BookingModel(id: 'b2', serviceId: 's5', serviceTitle: 'Electrical Panel Upgrade', categoryName: 'Electrical', providerId: 'p3', providerName: 'David Chen', providerAvatarSeed: 15, date: DateTime(2026, 9, 8), time: '2:00 PM', address: '221 Baker Street, San Francisco, CA', price: 350, status: BookingStatus.pending, paymentMethod: 'Cash on service'),
    BookingModel(id: 'b3', serviceId: 's10', serviceTitle: 'Bridal Makeup', categoryName: 'Beauty', providerId: 'p6', providerName: 'Sophia Martinez', providerAvatarSeed: 21, date: DateTime(2026, 8, 22), time: '9:00 AM', address: '221 Baker Street, San Francisco, CA', price: 180, status: BookingStatus.completed, paymentMethod: 'Visa •••• 4291', tipAmount: 20),
    BookingModel(id: 'b4', serviceId: 's3', serviceTitle: 'Leak Detection & Repair', categoryName: 'Plumbing', providerId: 'p2', providerName: 'Mike Rodriguez', providerAvatarSeed: 33, date: DateTime(2026, 8, 10), time: '11:30 AM', address: '221 Baker Street, San Francisco, CA', price: 130, status: BookingStatus.completed, paymentMethod: 'Mastercard •••• 7723', tipAmount: 15),
    BookingModel(id: 'b5', serviceId: 's9', serviceTitle: 'Math & Physics Tutoring', categoryName: 'Tutoring', providerId: 'p5', providerName: 'James Anderson', providerAvatarSeed: 52, date: DateTime(2026, 7, 30), time: '4:00 PM', address: 'Online session', price: 40, status: BookingStatus.cancelled, paymentMethod: 'Visa •••• 4291'),
    // Completed jobs for the logged-in provider (p1 / Sarah Johnson) so the
    // Provider Dashboard's earnings screen has real, non-zero data to chart.
    BookingModel(id: 'b6', serviceId: 's1', serviceTitle: 'Deep Home Cleaning', categoryName: 'Cleaning', providerId: 'p1', providerName: 'Sarah Johnson', providerAvatarSeed: 47, date: DateTime(2026, 8, 26), time: '9:00 AM', address: '88 Fillmore St, San Francisco, CA', price: 90, status: BookingStatus.completed, paymentMethod: 'Visa •••• 4291', tipAmount: 10),
    BookingModel(id: 'b7', serviceId: 's1', serviceTitle: 'Deep Home Cleaning', categoryName: 'Cleaning', providerId: 'p1', providerName: 'Sarah Johnson', providerAvatarSeed: 47, date: DateTime(2026, 8, 28), time: '1:00 PM', address: '340 Hayes St, San Francisco, CA', price: 135, status: BookingStatus.completed, paymentMethod: 'Mastercard •••• 7723', tipAmount: 15),
    BookingModel(id: 'b8', serviceId: 's2', serviceTitle: 'Move-in / Move-out Cleaning', categoryName: 'Cleaning', providerId: 'p1', providerName: 'Sarah Johnson', providerAvatarSeed: 47, date: DateTime(2026, 8, 31), time: '10:00 AM', address: '12 Church St, San Francisco, CA', price: 120, status: BookingStatus.completed, paymentMethod: 'Visa •••• 4291', tipAmount: 20),
    BookingModel(id: 'b9', serviceId: 's1', serviceTitle: 'Deep Home Cleaning', categoryName: 'Cleaning', providerId: 'p1', providerName: 'Sarah Johnson', providerAvatarSeed: 47, date: DateTime(2026, 9, 1), time: '9:30 AM', address: '561 Divisadero St, San Francisco, CA', price: 90, status: BookingStatus.completed, paymentMethod: 'Cash on service', tipAmount: 12),
    BookingModel(id: 'b10', serviceId: 's1', serviceTitle: 'Deep Home Cleaning', categoryName: 'Cleaning', providerId: 'p1', providerName: 'Sarah Johnson', providerAvatarSeed: 47, date: DateTime(2026, 9, 2), time: '8:00 AM', address: '221 Baker Street, San Francisco, CA', price: 90, status: BookingStatus.completed, paymentMethod: 'Visa •••• 4291', tipAmount: 18),
  ];

  static final List<NotificationModel> notifications = [
    NotificationModel(id: 'n1', title: 'Booking confirmed', message: 'Sarah Johnson confirmed your Deep Home Cleaning for Sep 5, 10:00 AM.', time: DateTime(2026, 9, 1, 14, 30), type: NotificationType.booking, isRead: false),
    NotificationModel(id: 'n2', title: 'New message', message: 'David Chen sent you a message about your panel upgrade.', time: DateTime(2026, 9, 1, 9, 5), type: NotificationType.message, isRead: false),
    NotificationModel(id: 'n3', title: 'Weekend discount', message: 'Get 20% off Beauty services this weekend only.', time: DateTime(2026, 8, 31, 18, 0), type: NotificationType.promo, isRead: true),
    NotificationModel(id: 'n4', title: 'Booking completed', message: 'Your Leak Detection & Repair with Mike Rodriguez is complete. Leave a review!', time: DateTime(2026, 8, 10, 13, 0), type: NotificationType.booking, isRead: true),
    NotificationModel(id: 'n5', title: 'App updated', message: 'We\'ve improved search and filters — check them out.', time: DateTime(2026, 8, 5, 8, 0), type: NotificationType.system, isRead: true),
  ];

  static final List<ChatThreadModel> chatThreads = [
    ChatThreadModel(
      id: 't1', name: 'Sarah Johnson', avatarSeed: 47, lastMessage: 'Great, see you at 10 AM!', time: DateTime(2026, 9, 1, 14, 32), unreadCount: 2, isOnline: true,
      messages: [
        ChatMessageModel(id: 'm1', text: 'Hi! Just confirming your deep clean tomorrow at 10 AM.', time: DateTime(2026, 9, 1, 14, 20), isMe: false),
        ChatMessageModel(id: 'm2', text: 'Yes that works for me, thank you!', time: DateTime(2026, 9, 1, 14, 25), isMe: true),
        ChatMessageModel(id: 'm3', text: 'Perfect, I\'ll bring eco-friendly supplies as requested.', time: DateTime(2026, 9, 1, 14, 28), isMe: false),
        ChatMessageModel(id: 'm4', text: 'Great, see you at 10 AM!', time: DateTime(2026, 9, 1, 14, 32), isMe: false),
      ],
    ),
    ChatThreadModel(
      id: 't2', name: 'David Chen', avatarSeed: 15, lastMessage: 'I can bring the parts needed for the upgrade.', time: DateTime(2026, 9, 1, 9, 5), unreadCount: 1, isOnline: true,
      messages: [
        ChatMessageModel(id: 'm5', text: 'Hi Alex, quick question about your panel — is it indoor or outdoor mounted?', time: DateTime(2026, 9, 1, 8, 58), isMe: false),
        ChatMessageModel(id: 'm6', text: 'It\'s in the garage, indoor.', time: DateTime(2026, 9, 1, 9, 2), isMe: true),
        ChatMessageModel(id: 'm7', text: 'I can bring the parts needed for the upgrade.', time: DateTime(2026, 9, 1, 9, 5), isMe: false),
      ],
    ),
    ChatThreadModel(
      id: 't3', name: 'Sophia Martinez', avatarSeed: 21, lastMessage: 'Thank you for the tip, it was a pleasure!', time: DateTime(2026, 8, 22, 12, 10), unreadCount: 0, isOnline: false,
      messages: [
        ChatMessageModel(id: 'm8', text: 'Hope you loved the bridal look today!', time: DateTime(2026, 8, 22, 12, 0), isMe: false),
        ChatMessageModel(id: 'm9', text: 'Absolutely stunning, thank you so much!', time: DateTime(2026, 8, 22, 12, 6), isMe: true),
        ChatMessageModel(id: 'm10', text: 'Thank you for the tip, it was a pleasure!', time: DateTime(2026, 8, 22, 12, 10), isMe: false),
      ],
    ),
    ChatThreadModel(
      id: 't4', name: 'Mike Rodriguez', avatarSeed: 33, lastMessage: 'Let me know if the leak comes back.', time: DateTime(2026, 8, 10, 15, 0), unreadCount: 0, isOnline: false,
      messages: [
        ChatMessageModel(id: 'm11', text: 'All fixed on my end — replaced the washer.', time: DateTime(2026, 8, 10, 14, 50), isMe: false),
        ChatMessageModel(id: 'm12', text: 'Awesome, thanks for the quick work!', time: DateTime(2026, 8, 10, 14, 55), isMe: true),
        ChatMessageModel(id: 'm13', text: 'Let me know if the leak comes back.', time: DateTime(2026, 8, 10, 15, 0), isMe: false),
      ],
    ),
  ];

  static ServiceModel serviceById(String id) => services.firstWhere((s) => s.id == id);
  static ProviderModel providerById(String id) => providers.firstWhere((p) => p.id == id);
  static CategoryModel categoryById(String id) => categories.firstWhere((c) => c.id == id);

  static List<ServiceModel> servicesByCategory(String categoryId) =>
      services.where((s) => s.categoryId == categoryId).toList();

  static List<ServiceModel> servicesByProvider(String providerId) =>
      services.where((s) => s.providerId == providerId).toList();

  static List<ReviewModel> reviewsByProvider(String providerId) =>
      reviews.where((r) => r.providerId == providerId).toList();

  static List<ServiceModel> get popularServices =>
      services.where((s) => s.isPopular).toList();
}
