import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const AmarRecipeApp());

class Recipe {
  final String id, name, category, country, image, time, description;
  final int minutes, servings;
  final bool featured;
  final List<String> ingredients, steps;

  const Recipe({
    required this.id,
    required this.name,
    required this.category,
    required this.country,
    required this.image,
    required this.time,
    required this.description,
    required this.minutes,
    required this.servings,
    required this.ingredients,
    required this.steps,
    this.featured = false,
  });
}

const recipes = <Recipe>[
  Recipe(id:'1',name:'চিকেন বিরিয়ানি',category:'ভাত',country:'বাংলাদেশ',image:'https://images.unsplash.com/photo-1563379091339-03246963d96c?auto=format&fit=crop&w=1200&q=85',time:'60 মিনিট',minutes:60,servings:4,description:'সুগন্ধি বাসমতি চাল, মসলা ও মুরগি দিয়ে তৈরি জনপ্রিয় বিরিয়ানি।',ingredients:['বাসমতি চাল','মুরগি ১ কেজি','পেঁয়াজ','আলু','দই','আদা-রসুন','বিরিয়ানি মসলা'],steps:['চাল ধুয়ে ২০ মিনিট ভিজিয়ে রাখুন।','মুরগি দই ও মসলা দিয়ে কষিয়ে নিন।','চাল ৭০% সেদ্ধ করুন।','হাঁড়িতে চাল ও মাংস স্তরে স্তরে দিন।','ঢেকে কম আঁচে ২০ মিনিট দম দিন।'],featured:true),
  Recipe(id:'2',name:'ইলিশ ভাজা',category:'মাছ',country:'বাংলাদেশ',image:'https://images.unsplash.com/photo-1547592180-85f173990554?auto=format&fit=crop&w=1200&q=85',time:'25 মিনিট',minutes:25,servings:3,description:'সরিষার তেল ও সাধারণ মসলা দিয়ে ঝটপট ইলিশ ভাজা।',ingredients:['ইলিশ','হলুদ','লবণ','মরিচ','সরিষার তেল'],steps:['মাছে লবণ ও হলুদ মাখান।','তেল গরম করুন।','মাঝারি আঁচে দুই পাশ সোনালি করে ভাজুন।'],featured:true),
  Recipe(id:'3',name:'বিফ ভুনা',category:'মাংস',country:'বাংলাদেশ',image:'https://images.unsplash.com/photo-1601050690597-df0568f70950?auto=format&fit=crop&w=1200&q=85',time:'75 মিনিট',minutes:75,servings:4,description:'ঝাল-মশলাদার ঘন গ্রেভির ঐতিহ্যবাহী বিফ ভুনা।',ingredients:['গরুর মাংস','পেঁয়াজ','আদা','রসুন','মরিচ','জিরা'],steps:['মাংস পরিষ্কার করে মসলা মাখান।','পেঁয়াজ বাদামি করে ভাজুন।','মাংস দিয়ে ভালোভাবে কষান।','অল্প পানি দিয়ে ঢেকে নরম করুন।','শেষে তেল ওপরে উঠা পর্যন্ত ভুনুন.'],featured:true),
  Recipe(id:'4',name:'ডাল ভর্তা',category:'ভর্তা',country:'বাংলাদেশ',image:'https://images.unsplash.com/photo-1515003197210-e0cd71810b5f?auto=format&fit=crop&w=1200&q=85',time:'20 মিনিট',minutes:20,servings:3,description:'গরম ভাতের সঙ্গে দারুণ মানানসই সহজ ডাল ভর্তা।',ingredients:['মসুর ডাল','পেঁয়াজ','কাঁচা মরিচ','ধনেপাতা','সরিষার তেল'],steps:['ডাল নরম করে সেদ্ধ করুন।','পেঁয়াজ ও মরিচ কুচি করুন।','সব উপকরণ একসঙ্গে মেখে নিন।'],featured:true),
  Recipe(id:'5',name:'চিকেন কারি',category:'মাংস',country:'ভারত',image:'https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?auto=format&fit=crop&w=1200&q=85',time:'50 মিনিট',minutes:50,servings:4,description:'ঘরোয়া ভারতীয় স্টাইলে মশলাদার চিকেন কারি।',ingredients:['চিকেন','পেঁয়াজ','টমেটো','দই','গরম মসলা'],steps:['পেঁয়াজ ভাজুন।','আদা-রসুন ও মসলা কষান।','চিকেন যোগ করে ভাজুন।','টমেটো ও পানি দিয়ে রান্না করুন।'],featured:true),
  Recipe(id:'6',name:'চিকেন চাওমিন',category:'নুডলস',country:'চীন',image:'https://images.unsplash.com/photo-1552611052-33e04de081de?auto=format&fit=crop&w=1200&q=85',time:'25 মিনিট',minutes:25,servings:2,description:'সবজি, চিকেন ও সয়া সসের দ্রুত চাইনিজ নুডলস।',ingredients:['নুডলস','চিকেন','গাজর','ক্যাপসিকাম','সয়া সস'],steps:['নুডলস সেদ্ধ করে পানি ঝরান।','চিকেন ও সবজি উচ্চ আঁচে ভাজুন।','নুডলস ও সয়া সস দিয়ে মিশিয়ে নিন।'],featured:true),
  Recipe(id:'7',name:'ক্রিমি পাস্তা',category:'পাস্তা',country:'ইতালি',image:'https://images.unsplash.com/photo-1551183053-bf91a1d81141?auto=format&fit=crop&w=1200&q=85',time:'30 মিনিট',minutes:30,servings:2,description:'ক্রিমি সস ও চিজের সহজ ইতালিয়ান পাস্তা।',ingredients:['পাস্তা','ক্রিম','চিজ','রসুন','কালো মরিচ'],steps:['পাস্তা সেদ্ধ করুন।','রসুন হালকা ভাজুন।','ক্রিম ও চিজ দিয়ে সস তৈরি করুন।','পাস্তা মিশিয়ে পরিবেশন করুন।']),
  Recipe(id:'8',name:'থাই নুডলস',category:'নুডলস',country:'থাইল্যান্ড',image:'https://images.unsplash.com/photo-1559314809-0d155014e29e?auto=format&fit=crop&w=1200&q=85',time:'30 মিনিট',minutes:30,servings:2,description:'মিষ্টি-ঝাল স্বাদের জনপ্রিয় থাই নুডলস।',ingredients:['রাইস নুডলস','সবজি','সয়া সস','লেবু','বাদাম'],steps:['নুডলস নরম করুন।','সবজি ভাজুন।','সস ও নুডলস মিশিয়ে নিন।','লেবু ও বাদাম দিয়ে পরিবেশন করুন.']),
];

class AmarRecipeApp extends StatefulWidget {
  const AmarRecipeApp({super.key});
  @override State<AmarRecipeApp> createState() => _AppState();
}

class _AppState extends State<AmarRecipeApp> {
  bool dark = false;
  @override Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner:false,
    title:'আমার রেসিপি',
    themeMode: dark ? ThemeMode.dark : ThemeMode.light,
    theme: ThemeData(useMaterial3:true,colorSchemeSeed:Colors.deepOrange,scaffoldBackgroundColor:const Color(0xFFFFFBF7)),
    darkTheme: ThemeData(useMaterial3:true,colorSchemeSeed:Colors.deepOrange,brightness:Brightness.dark),
    home: HomePage(onThemeChanged:(v)=>setState(()=>dark=v),dark:dark),
  );
}

class HomePage extends StatefulWidget {
  final bool dark; final ValueChanged<bool> onThemeChanged;
  const HomePage({super.key,required this.dark,required this.onThemeChanged});
  @override State<HomePage> createState()=>_HomeState();
}

class _HomeState extends State<HomePage> {
  int tab=0; String query=''; String selectedCategory='সব'; Set<String> favorites={};
  final categories=['সব','ভাত','মাছ','মাংস','ভর্তা','নুডলস','পাস্তা'];
  final countries=['সব দেশ','বাংলাদেশ','ভারত','চীন','থাইল্যান্ড','ইতালি'];
  String country='সব দেশ';

  @override void initState(){super.initState(); _loadFavorites();}
  Future<void> _loadFavorites() async { final p=await SharedPreferences.getInstance(); setState(()=>favorites=p.getStringList('favorites')?.toSet()??{}); }
  Future<void> toggleFavorite(String id) async { final p=await SharedPreferences.getInstance(); setState(()=>favorites.contains(id)?favorites.remove(id):favorites.add(id)); await p.setStringList('favorites',favorites.toList()); }
  List<Recipe> get filtered => recipes.where((r)=> (selectedCategory=='সব'||r.category==selectedCategory) && (country=='সব দেশ'||r.country==country) && (query.trim().isEmpty||r.name.contains(query)||r.category.contains(query)||r.country.contains(query))).toList();

  @override Widget build(BuildContext context){
    final pages=[_home(),_explore(),_favorites(),_profile()];
    return Scaffold(body:SafeArea(child:pages[tab]),bottomNavigationBar:NavigationBar(selectedIndex:tab,onDestinationSelected:(i)=>setState(()=>tab=i),destinations:const[
      NavigationDestination(icon:Icon(Icons.home_outlined),selectedIcon:Icon(Icons.home),label:'হোম'),
      NavigationDestination(icon:Icon(Icons.explore_outlined),selectedIcon:Icon(Icons.explore),label:'এক্সপ্লোর'),
      NavigationDestination(icon:Icon(Icons.favorite_border),selectedIcon:Icon(Icons.favorite),label:'ফেভারিট'),
      NavigationDestination(icon:Icon(Icons.person_outline),selectedIcon:Icon(Icons.person),label:'প্রোফাইল'),
    ]));
  }

  Widget _search(){return TextField(onChanged:(v)=>setState(()=>query=v),decoration:InputDecoration(prefixIcon:const Icon(Icons.search),suffixIcon:query.isEmpty?null:IconButton(onPressed:()=>setState(()=>query=''),icon:const Icon(Icons.close)),hintText:'রেসিপি, উপকরণ বা দেশ খুঁজুন...',filled:true,fillColor:Theme.of(context).colorScheme.surfaceContainerHighest,border:OutlineInputBorder(borderRadius:BorderRadius.circular(18),borderSide:BorderSide.none)));}

  Widget _home()=>ListView(padding:const EdgeInsets.fromLTRB(16,10,16,24),children:[
    Row(children:[Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('আসসালামু আলাইকুম 👋',style:TextStyle(color:Theme.of(context).colorScheme.primary,fontWeight:FontWeight.w600)),const SizedBox(height:3),Text('আজ কী রান্না করবেন?',style:Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight:FontWeight.w800))])),IconButton(onPressed:()=>widget.onThemeChanged(!widget.dark),icon:Icon(widget.dark?Icons.light_mode:Icons.dark_mode))]),
    const SizedBox(height:14),_search(),const SizedBox(height:22),
    _sectionTitle('আজকের বিশেষ রেসিপি','সব দেখুন',()=>setState(()=>tab=1)),
    const SizedBox(height:10),SizedBox(height:220,child:ListView.separated(scrollDirection:Axis.horizontal,itemCount:recipes.where((r)=>r.featured).length,itemBuilder:(c,i)=>_featured(recipes.where((r)=>r.featured).toList()[i]),separatorBuilder:(_,__)=>const SizedBox(width:14))),
    const SizedBox(height:24),
    _sectionTitle('ক্যাটাগরি','সব',()=>setState(()=>tab=1)),const SizedBox(height:10),SizedBox(height:92,child:ListView.separated(scrollDirection:Axis.horizontal,itemCount:categories.length,itemBuilder:(c,i)=>_categoryChip(categories[i]),separatorBuilder:(_,__)=>const SizedBox(width:10))),
    const SizedBox(height:24),_sectionTitle('জনপ্রিয় রেসিপি','সব দেখুন',()=>setState(()=>tab=1)),const SizedBox(height:10),_grid(filtered),
  ]);

  Widget _sectionTitle(String a,String b,VoidCallback on)=>Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[Text(a,style:const TextStyle(fontSize:20,fontWeight:FontWeight.w800)),TextButton(onPressed:on,child:Text(b))]);

  Widget _featured(Recipe r)=>SizedBox(width:310,child:ClipRRect(borderRadius:BorderRadius.circular(24),child:Stack(fit:StackFit.expand,children:[Image.network(r.image,fit:BoxFit.cover,errorBuilder:(_,__,___)=>Container(color:Colors.orange.shade100,child:const Icon(Icons.restaurant,size:55))),Container(decoration:const BoxDecoration(gradient:LinearGradient(begin:Alignment.topCenter,end:Alignment.bottomCenter,colors:[Colors.transparent,Colors.black87]))),Positioned(top:10,right:10,child:_heart(r)),Positioned(left:16,right:16,bottom:15,child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(r.name,style:const TextStyle(color:Colors.white,fontSize:22,fontWeight:FontWeight.bold)),const SizedBox(height:4),Text('${r.country} • ${r.time}',style:const TextStyle(color:Colors.white70)),const SizedBox(height:6),FilledButton.tonal(onPressed:()=>_open(r),child:const Text('রেসিপি দেখুন'))]))])));

  Widget _categoryChip(String c)=>GestureDetector(onTap:(){setState(()=>selectedCategory=c);},child:Container(width:78,padding:const EdgeInsets.all(8),decoration:BoxDecoration(color:selectedCategory==c?Theme.of(context).colorScheme.primaryContainer:Theme.of(context).colorScheme.surfaceContainerHighest,borderRadius:BorderRadius.circular(18)),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(_iconFor(c),size:27),const SizedBox(height:5),Text(c,overflow:TextOverflow.ellipsis)])));
  IconData _iconFor(String c){switch(c){case 'ভাত':return Icons.rice_bowl;case 'মাছ':return Icons.set_meal;case 'মাংস':return Icons.lunch_dining;case 'ভর্তা':return Icons.soup_kitchen;case 'নুডলস':return Icons.ramen_dining;case 'পাস্তা':return Icons.dinner_dining;default:return Icons.restaurant;}}

  Widget _grid(List<Recipe> list)=>GridView.builder(shrinkWrap:true,physics:const NeverScrollableScrollPhysics(),itemCount:list.length,gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,crossAxisSpacing:12,mainAxisSpacing:12,childAspectRatio:.68),itemBuilder:(c,i)=>_card(list[i]));
  Widget _card(Recipe r)=>Card(clipBehavior:Clip.antiAlias,elevation:0,child:InkWell(onTap:()=>_open(r),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Expanded(child:Stack(fit:StackFit.expand,children:[Image.network(r.image,fit:BoxFit.cover,errorBuilder:(_,__,___)=>Container(color:Theme.of(context).colorScheme.surfaceContainerHighest,child:const Icon(Icons.restaurant,size:45))),Positioned(top:7,right:7,child:_heart(r))])),Padding(padding:const EdgeInsets.fromLTRB(10,10,10,2),child:Text(r.name,maxLines:1,overflow:TextOverflow.ellipsis,style:const TextStyle(fontWeight:FontWeight.w800))),Padding(padding:const EdgeInsets.fromLTRB(10,2,10,10),child:Text('${r.country} • ${r.time}',maxLines:1,overflow:TextOverflow.ellipsis,style:TextStyle(color:Theme.of(context).colorScheme.onSurfaceVariant,fontSize:12))) ])));
  Widget _heart(Recipe r)=>Material(color:Colors.white.withOpacity(.92),shape:const CircleBorder(),child:IconButton(visualDensity:VisualDensity.compact,onPressed:()=>toggleFavorite(r.id),icon:Icon(favorites.contains(r.id)?Icons.favorite:Icons.favorite_border,color:favorites.contains(r.id)?Colors.red:Colors.black87)));

  Widget _explore()=>ListView(padding:const EdgeInsets.fromLTRB(16,10,16,24),children:[Text('এক্সপ্লোর করুন 🌎',style:Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight:FontWeight.w800)),const SizedBox(height:6),const Text('দেশ ও ক্যাটাগরি বেছে নিয়ে আপনার পছন্দের রান্না খুঁজুন.'),const SizedBox(height:18),_search(),const SizedBox(height:18),const Text('দেশ',style:TextStyle(fontSize:18,fontWeight:FontWeight.w800)),const SizedBox(height:10),SizedBox(height:48,child:ListView.separated(scrollDirection:Axis.horizontal,itemCount:countries.length,itemBuilder:(c,i)=>ChoiceChip(label:Text(countries[i]),selected:country==countries[i],onSelected:(_)=>setState(()=>country=countries[i])),separatorBuilder:(_,__)=>const SizedBox(width:8))),const SizedBox(height:20),const Text('ক্যাটাগরি',style:TextStyle(fontSize:18,fontWeight:FontWeight.w800)),const SizedBox(height:10),Wrap(spacing:8,runSpacing:8,children:categories.map((c)=>ChoiceChip(label:Text(c),selected:selectedCategory==c,onSelected:(_)=>setState(()=>selectedCategory=c))).toList()),const SizedBox(height:20),_grid(filtered)]);

  Widget _favorites()=>ListView(padding:const EdgeInsets.fromLTRB(16,14,16,24),children:[Text('আমার ফেভারিট ❤️',style:Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight:FontWeight.w800)),const SizedBox(height:14),if(favorites.isEmpty)const Padding(padding:EdgeInsets.only(top:80),child:Center(child:Column(children:[Icon(Icons.favorite_border,size:70),SizedBox(height:12),Text('এখনও কোনো রেসিপি সেভ করেননি',style:TextStyle(fontSize:18,fontWeight:FontWeight.w700)),SizedBox(height:6),Text('পছন্দের রেসিপির ❤️ বাটনে চাপ দিন.')]))) else _grid(recipes.where((r)=>favorites.contains(r.id)).toList())]);

  Widget _profile()=>ListView(padding:const EdgeInsets.all(20),children:[const SizedBox(height:15),CircleAvatar(radius:44,child:const Icon(Icons.restaurant_menu,size:42)),const SizedBox(height:14),const Center(child:Text('আমার রেসিপি',style:TextStyle(fontSize:25,fontWeight:FontWeight.w800))),const SizedBox(height:5),Center(child:Text('${recipes.length} টি রেসিপি • ${favorites.length} টি ফেভারিট')),const SizedBox(height:28),Card(child:SwitchListTile(value:widget.dark,onChanged:widget.onThemeChanged,title:const Text('Dark Mode'),subtitle:const Text('রাতে আরামদায়কভাবে ব্যবহার করুন'),secondary:const Icon(Icons.dark_mode))),Card(child:ListTile(leading:const Icon(Icons.info_outline),title:const Text('অ্যাপ সম্পর্কে'),subtitle:const Text('আমার রেসিপি • Version 3.0')))]);

  void _open(Recipe r)=>Navigator.push(context,MaterialPageRoute(builder:(_)=>RecipeDetails(recipe:r,isFavorite:favorites.contains(r.id),onFavorite:()=>toggleFavorite(r.id))));
}

class RecipeDetails extends StatelessWidget {
  final Recipe recipe;
  final bool isFavorite;
  final VoidCallback onFavorite;

  const RecipeDetails({
    super.key,
    required this.recipe,
    required this.isFavorite,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('রেসিপি'),
        actions: [
          IconButton(
            onPressed: onFavorite,
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : null,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 16 / 10,
            child: Image.network(
              recipe.image,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: const Icon(Icons.restaurant, size: 70),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipe.name,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 7),
                Text('${recipe.country} • ${recipe.category}'),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _stat(context, Icons.timer_outlined, recipe.time),
                    const SizedBox(width: 10),
                    _stat(
                      context,
                      Icons.people_outline,
                      '${recipe.servings} জন',
                    ),
                    const SizedBox(width: 10),
                    _stat(
                      context,
                      Icons.local_fire_department_outlined,
                      'সহজ',
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  recipe.description,
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
                const SizedBox(height: 24),
                const Text(
                  'উপকরণ',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 10),
                ...recipe.ingredients.map(
                  (x) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.check_circle_outline),
                    title: Text(x),
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'রান্নার নিয়ম',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    FilledButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CookingMode(recipe: recipe),
                          ),
                        );
                      },
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Cooking Mode'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ...recipe.steps.asMap().entries.map(
                  (e) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(child: Text('${e.key + 1}')),
                    title: Text(
                      e.value,
                      style: const TextStyle(height: 1.4),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _stat(BuildContext c, IconData icon, String text) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(c).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Icon(icon, size: 22),
            const SizedBox(height: 3),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

class CookingMode extends StatefulWidget {
  final Recipe recipe;

  const CookingMode({super.key, required this.recipe});

  @override
  State<CookingMode> createState() => _CookingState();
}

class _CookingState extends State<CookingMode> {
  int step = 0;

  @override
  Widget build(BuildContext context) {
    final r = widget.recipe;
    final lastStep = step >= r.steps.length - 1;

    return Scaffold(
      appBar: AppBar(title: const Text('Cooking Mode')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'STEP ${step + 1} / ${r.steps.length}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 24),
            LinearProgressIndicator(
              value: (step + 1) / r.steps.length,
              minHeight: 8,
              borderRadius: BorderRadius.circular(8),
            ),
            const Spacer(),
            const Icon(Icons.soup_kitchen_outlined, size: 80),
            const SizedBox(height: 30),
            Text(
              r.steps[step],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                height: 1.35,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                if (step > 0) ...[
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => setState(() => step--),
                      child: const Text('← আগের ধাপ'),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
                Expanded(
                  child: FilledButton(
                    onPressed: lastStep
                        ? () => Navigator.pop(context)
                        : () => setState(() => step++),
                    child: Text(lastStep ? 'শেষ হয়েছে ✓' : 'পরের ধাপ →'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
