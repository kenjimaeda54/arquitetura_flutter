# Ciclar 
Projeto mobile realizado com Flutter


## Projeto
- Projeto segue o raciocínio Ofline First, então possue banco local, riverpod, hooks,dio.
- Abaixo estrutura do software

  
```dart

  lib
    |-- data(Diretório responsável pelos dados)
    |        |client(Diretório responsável pelos serviços externos)
    |        |       |contracts(Diretório com as implementações para os serviços externos)
    |        |       |services(Diretório com os serviços externo)
    |        |       base_client(Classe abstrata com implementação do Dio)
    |        |       data_or_exception (Classe para auxiliar uso dos serviços)
    |        |
    |        |database(Diretório com os recursos relacionado ao banco local)
    |        |       |contracts(Diretório com as implementações para o banco local)
    |        |       |resources(Diretório com serviços para database)
    |        |       core_database(Classe principal com implementação do database)
    |        |       
    |        |local(Diretório com os recursos dos bancos locais)
    |        |model (Diretório com os nossos models)
    |        |repository(Diretório responsável por determinar qual tipo de dado vai mostrar)
    |
    |-- di(Diretório com injeção dependência)  
    |-- ui(Diretório responsável pela apresentação )
    |    |screens(Diretório responsável pelas telas)
    |    |    |widget(Diretório opcional se precisar criar um widget especifico da tela)
    |    |widgets(Diretório com os widgets que se repetem constantemente no projeto)
    |-- utils(Diretório  com coisas que utilizamos no projeto como todo e não se enquadram nos outros)
    |
    main

```
- Vamos supor que precisa criar um novo serviço
- Primeiramente cria seu model com [frezzed](https://pub.dev/packages/freezed)
- Repara que ele utiliza conceito de prefix _$< nome da classe >, precisa ser exatamente assim
- Único dado alterar neste exemplo e os dados que sao requisitos da classe, precisam ser o mesmo da [API](https://jsonplaceholder.typicode.com/posts) 
- Por padrão iremos sempre criar uma classe abstrata e colocarmos esse campo creatAt com este dado iremos fazer um cálculo para identificar quando atualizar o dado local,mostrar o local ou remoto.
- Motivo da classe abstrata, porque frezed não consegue criar o código automático sem ele
- Se não precisássemos criar uma implementação própria sem o factory não seria necessário 
- Conforme estiver criando a classe ira dar erro não se preocupe com alguns dos erros após gerar o código automático deveria eliminar
- Se atenta ao .freezed e o .g ,estes arquivos não existem até gerarmos o código automatico também precisam ser seguidas exatamente do nome do arquivo
- Após criado usa o comando dart run build_runner build


```dart
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'posts_placeholder.freezed.dart';
part 'posts_placeholder.g.dart';

abstract class PostsPlaceHolderDatabase {
  Map<String, dynamic> mapPlaceholder();
}

@freezed
class PostsPlaceholder
    with _$PostsPlaceholder
    implements PostsPlaceHolderDatabase {
  const PostsPlaceholder._();
  const factory PostsPlaceholder({
    required int userId,
    required int id,
    required String title,
    required String body,
    int? createAt,
  }) = _PostsPlaceholder;

  factory PostsPlaceholder.fromJson(Map<String, dynamic> json) =>
      _$PostsPlaceholderFromJson(json);

  factory PostsPlaceholder.fromEmpty() => const PostsPlaceholder(
        userId: 0,
        id: 0,
        title: '',
        body: '',
      );

  @override
  Map<String, dynamic> mapPlaceholder() => {
        'userId': userId,
        'id': id,
        'title': title,
        'body': body,
        'createAt': DateTime.now().millisecondsSinceEpoch,
      };
}


```

##

- Após criado o model pode iniciar a implementação dos contratos que serão consumidos no serviço
- Por herança estamos herdando os métodos da BaseClient repara que nos serviços não me preocupo com os erros da API, porque nesta classe que eta sendo herdado tem um interceptador do DIO , assim caso futuramente optarmos com uma ferramenta de observabilidade  fica simples implantar

```dart
//contracts
  
abstract class IPlaceholderPosts {
  Future<DataOrException<List<PostsPlaceholder>>> getPostsPlaceholder();
}

//services
class PostsServices extends BaseClient implements IPlaceholderPosts {
  @override
  Future<DataOrException<List<PostsPlaceholder>>> getPostsPlaceholder() async {
    try {
      final response = await customDio().get("/posts");
      return DataOrException(
          data: (response.data as List<dynamic>)
              .map((it) => PostsPlaceholder.fromJson(it))
              .toList(),
          exception: null,
          loading: Loading.success);
    } catch (e) {
      return DataOrException(
          data: null, exception: e.toString(), loading: Loading.failure);
    }
  }
}

//base client
abstract class BaseClient {
  Dio customDio() {
    Dio dio = Dio();
    dio.options = BaseOptions(
        baseUrl: "https://jsonplaceholder.typicode.com",
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10));
    dio.interceptors.add(InterceptorsWrapper(
      onError: (error, handler) {
        print("onError fetch: ${error.message}");
        return handler.next(error);
      },
    ));
    return dio;
  }
}

```

##
- Após criado o serviço está na hora de criarmos o dado local, existem momentos que não iremos implementar estes dados, vai depender muito do caso de uso
- Primeiramente recomendo criar em NameTable o nome da tabela, assim evitamos futuros erros inconvenientes com nomes das tabelas
- Depois podemos   ir no  CoreDabase e criar a nova tabela
- Sempre que criar uma nova tabela precisa alterar a versão do Database para gerar a mutação

  
```dart

//name_table
class NameTable {
  static String postPlaceHolder = "postsPlaceHolder";
}


//database

class CoreDatabase {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await createDataBase();
    return _database!;
  }

  createDataBase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "ciclar.db");

    try {
      await Directory(databasesPath).create(recursive: true);
    } catch (e) {
      print("can't create databases path");
    }

    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE ${NameTable.postPlaceHolder}(id INTEGER PRIMARY KEY, userId INTEGER, title TEXT, body TEXT, createAt INTEGER, FOREIGN KEY(id) REFERENCES ${NameTable.postPlaceHolder}(id) ON DELETE CASCADE)',
    await db.execute(
     cria uma nova tabela
 )

    );
  }
}

```




##
- Depois ter criado sua tabela está no momento de criar os contratos do dado local

```dart
//database/contracts

abstract class IPostsResources {
  Future<List<PostsPlaceholder>> getPostsPlaceholder();
  createPostPlaceHolder(List<PostsPlaceholder> postsPlaceholder);
}


```
##
- Com essa implementação pronta está no momento de criar a injeção dependência
- Repara que uso o lazy para os serviços  das API poderia usar o async também ambos funcionam bem, importante que seja um singleton para sempre termos a mesma referência
- Repara que são as implementações, ou seja IPostsResources,IPlaceholderPosts neste exemplo
  
```dart
//di

getIt.registerSingleton<IPostsResources>(PostDatabase());
getIt.registerLazySingleton<IPlaceholderPosts>(() => PostsServices());

```
##
- Com o contrato criado e as injeções dependências prontas posso criar quem implementa para os métodos que iram manipular  tabela criada
- 
```dart

class PostDatabase implements IPostsResources {
  @override
  createPostPlaceHolder(List<PostsPlaceholder> postsPlaceholder) async {
    final db = await getIt<CoreDatabase>().database;
    for (var element in postsPlaceholder) {
      await db.insert(NameTable.postPlaceHolder, element.mapPlaceholder(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  @override
  Future<List<PostsPlaceholder>> getPostsPlaceholder() async {
    final db = await getIt<CoreDatabase>().database;
    final List<Map<String, dynamic>> maps =
        await db.query(NameTable.postPlaceHolder);
    return List.generate(maps.length, (i) {
      return PostsPlaceholder.fromJson(maps[i]);
    });
  }
}


```

##
- Antes de terminamos precisamos criar abstração dentro  pasta local   
- Importante essa etapa para evitar acoplamento assim o local não sabe como foi implementado os métodos da tabela

```dart
//local

class PostsResourceLocal implements IPostsResources {
  @override
  createPostPlaceHolder(List<PostsPlaceholder> postsPlaceholder) {
    getIt<PostDatabase>().createPostPlaceHolder(postsPlaceholder);
  }

  @override
  Future<List<PostsPlaceholder>> getPostsPlaceholder() {
    return getIt<PostDatabase>().getPostsPlaceholder();
  }
}

```

##
- Por fim conecto todos no repository
- Segue mesma ideia do frezzed no quesito de criar código automatico, ou seja, preciso do arquivo  .g,  inclusive o usar comando que mencionei
- No repository estamos usando um helper que consulta o campo createdAt para atualizar ou não o dado local
- Return das condições e necessário para evitar que o código continue sendo executado e sobrescreva de forma errado o state
- State e injetado pelo próprio riverpod
- Na função do helper eu espero dois campos createAt é o withTimeMinutes
- withTimeMinutes é o tempo que iremos comparar para atualizar, no exemplo abaixo a cada um minuto eu   verifico se posso atualizar
- Caso não possua conexão com a internet ou o tempo é menor em relação ao withTimeMinutes, helper retorna false
 

```dart
import 'package:ciclar_mobile/data/client/contracts/i_placeholder_posts.dart';
import 'package:ciclar_mobile/data/client/data_or_exception.dart';
import 'package:ciclar_mobile/data/database/contracts/i_posts_resources.dart';
import 'package:ciclar_mobile/data/model/posts/posts_placeholder.dart';
import 'package:ciclar_mobile/di/di.dart';
import 'package:ciclar_mobile/utils/helpers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'posts_repository.g.dart';

@riverpod
class PostsRepository extends _$PostsRepository {
  @override
  DataOrException<List<PostsPlaceholder>> build() {
    getPosts();
    return DataOrException(
        data: null, exception: null, loading: Loading.loading);
  }

  getPosts() async {
    final resultLocal = await getIt<IPostsResources>().getPostsPlaceholder();
    if (resultLocal.isNotEmpty) {
      final helper = Helpers();
      final canUpdate = await helper.shouldUpdateOrNoDatabase(
          compare: resultLocal[0].createAt, withTimeMinutes: 1);
      if (canUpdate) {
        final resultRemote =
            await getIt<IPlaceholderPosts>().getPostsPlaceholder();
        getIt<IPostsResources>().createPostPlaceHolder(resultRemote.data!);
        state = resultRemote;
        return;
      }

      state = DataOrException(
          data: resultLocal, exception: null, loading: Loading.success);
      return;
    }
    final resultRemote = await getIt<IPlaceholderPosts>().getPostsPlaceholder();
    getIt<IPostsResources>().createPostPlaceHolder(resultRemote.data!);
    state = resultRemote;
  }
}


```

##

- Agora momento de exibir na tela
- Nesse exemplo nunca vai entrar condição Loading.none, pois é apenas um GET, ou seja, assim que iniciar estar classe começa  em loading, mas se for um post pode ser necessário o uso, dai depende do caso de uso
- Repara que no  método .push do navigator eu usei o ref.read, motivo que essa tela nunca sera destruída, assim precisaria de uma forma   atualizar o dado sempre que a tela estivesse em foco novamente, resumidamente se colocar um break point ira perceber que sempre que a tela está em foco independente se está destruída ou não ira chamar essa função, isso importante assim mantenho os dados atualizados


```dart
import 'package:ciclar_mobile/data/client/data_or_exception.dart';
import 'package:ciclar_mobile/data/model/posts/posts_placeholder.dart';
import 'package:ciclar_mobile/data/repository/posts/posts_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DataOrException<List<PostsPlaceholder>> posts =
        ref.watch(postsRepositoryProvider);

    return Scaffold(
        body: switch (posts.loading) {
      Loading.none => throw UnimplementedError(),
      Loading.loading => const Center(child: CircularProgressIndicator()),
      Loading.success => returnData(data: posts.data!, ref: ref),
      Loading.failure => const Text("error")
    });
  }
}

Widget returnData(
    {required List<PostsPlaceholder> data, required WidgetRef ref}) {
  return (ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () =>
                      GoRouter.of(context).push("/details").then((value) {
                    ref.read(postsRepositoryProvider.notifier).getPosts();
                  }),
                  child: const Text("Navegar para outra tela"),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(data[index].title),
              ],
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
          child: Text(data[index].title),
        );
      }));
}

```


# Video do caso de uso
- Separei o vídeo em três partes , porque github tem uma limitação
- Sempre que o dado é salvo acontece um cache local, pois não precisa realizar o  get ate a data atual com diferença do creatAt, sejam maiores que o tempo em  withTimeMinutes
- Repara no devtols que só acontece um GET  conforme navego entre as telas até o tempo expirar, aquele SOCKET  não uma requisição da nossa implementação, ou seja não temos controle


https://github.com/user-attachments/assets/35b19a90-cb3c-434c-938c-4e2a60fa2342


- Video com a internet desligada, provando que estamos usando o dado local



https://github.com/user-attachments/assets/de8bee22-3527-4280-8a75-1784f364745c


- Video apos ligar a internet, repara que apos internet reconectar e um determinado tempo é feito  um GET 



https://github.com/user-attachments/assets/bda6f271-2748-44cf-883d-79fb7a1f1f81




## WorFlow

```dart

stg  develop
|    |
|    |
|    |develop ---> inicio uma branch a partir da develop. Exemplo feat/criar_model
|    |           | recomendo sempre a cada dia quando for iniciar dar um git pull na develop
|    |           |
|    |           |
|    |           | apos concluído os trabalhos, faço abro uma PR para develop novamente
|    |           |
|    |-----------| Colega aprova é mergeia novamente a develop
|    |
|    |
|    | --> concluido os marcos(sprint) mergeamos na branch stg
-----             
|    |
|    |
|
| Na branch stg posteriromente iremos criiar uma pipeline para gerar os artefatos para IOS e Android

```











