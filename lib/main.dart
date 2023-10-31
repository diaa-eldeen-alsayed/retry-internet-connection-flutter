import 'package:flutter/material.dart';
import 'package:internet_connection_retry/features/presentation/cubit/features/post/presentation/cubit/post_cubit.dart';
import 'injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main()async {
    await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
    
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});




  

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
    late String firstPostTitle;
  late bool isLoading;
@override
  void initState() {
      firstPostTitle = 'Press the button 👇';
    isLoading = false;
    super.initState();
  }

 

  @override
  Widget build(BuildContext context) {
   return BlocProvider(create: (_) =>PostCubit(),child: BlocBuilder<PostCubit,PostState>(builder:(ctx,state){
        return  Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (state is PostLoading)
              const CircularProgressIndicator()
              else if (state is PostError)
                Text(
                state.message,
                style: const TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              )
              
            else if(state is PostLoad) ...[
                Text(state.response.data[0]['title'] as String,
                style: const TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            TextButton(
              child: const Text('REQUEST DATA'),
              onPressed: () async {
              ctx.read<PostCubit>().getPost();
                
               
              },
            )
            ]
            else
             TextButton(
              child: const Text('REQUEST DATA'),
              onPressed: () async {
                
                 ctx.read<PostCubit>().getPost();
                
              },
            )
            
          ],
        ),
      ),
    );

    } ,),);
   
   
  }
}
