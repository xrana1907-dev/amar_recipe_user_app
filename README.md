# রান্নাঘর Android App

নাম: **রান্নাঘর**

এই প্যাকেজে আছে:
- `lib/main.dart` — নতুন নাম ও লোগোসহ অ্যাপের মূল কোড
- `assets/rannaghor_logo.png` — রান্নাঘরের লোগো
- `.github/workflows/build-apk.yml` — GitHub Actions দিয়ে APK build
- `flutter_launcher_icons` — APK-র launcher icon হিসেবে লোগো সেট করার জন্য

## GitHub-এ ব্যবহার
1. পুরোনো User App repo-র `lib/main.dart` দিয়ে এই `main.dart` replace করুন।
2. `assets/rannaghor_logo.png` আপলোড করুন।
3. `pubspec.yaml`-এর এই নতুন version ব্যবহার করুন।
4. `.github/workflows/build-apk.yml` replace করুন।
5. GitHub Actions → Build Rannaghor Android APK → Run workflow।

নোট: Supabase/live Admin sync এখনো এই ফাইলে যোগ করা হয়নি; এটি বর্তমান local/demo recipe version-এর উপর ভিত্তি করে।
