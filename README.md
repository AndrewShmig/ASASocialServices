# ASASocialServices

[Основная директория](https://github.com/AndrewShmig/ASASocialServices/tree/master/DPSocialServices/DPSocialServices/SocialServices) модуля.

## DPTwitterCommunicator

Класс используемый для получения доступа к пользовательскому аккаунту Twitter.

**Как использовать?**

Подключаем заголовочные файлы:
````objective-c
#import "DPTwitterCommunicator.h"
#import "DPTwitterUserAccount.h"
````

Второй импорт подключает класс, который позволит нам осуществлять запросы к Twitter от лица текущего пользователя.
В заголовочном файла TwitterCommunicator есть две константы, данные в которых необходимо заменить на актуальные: TWITTER_CONSUMER_KEY и TWITTER_CONSUMER_SECRET

После того, как класс подключен необходимо произвести его инициализацию:
````objective-c
- (id)initWithWebView:(UIWebView *)webView;
````

webView - UIWebView, который будет использоваться для загрузки страницы Twitter требующей авторизации пользователем приложения.

webView - является свойством.
````objective-c
@property (nonatomic, weak) UIWebView *webView;
````

На данном этапе мы лишь создали объект для работы с Twitter, но сам процесс получения данных еще не начали.

Данный код запускает процесс получения пользовательских данных. Три блока обрабатывают все случаи: отказ пользователя авторизовать приложение, ошибка произошедшая при запросе и удачная авторизация приложения.
Результатом удачной авторизации будет служить пользовательский класс Twitter'а с данными пользователя от лица которого уже и можно осуществлять запросы.
````objective-c
[twitter  startOnCancelBlock:^{
            
} onErrorBlock:^(NSError *error) {
            
} onSuccessBlock:^(DPTwitterUserAccount *account) {
            
}];
````

Блок onSuccessBlock должен содержать в себе код для сохранения пользовательских данных в хранилище, будь то NSUserDefaults или DB.

У класса DPTwitterUserAccount есть особенно при осуществлении запросов: до выполнения какого-то запроса необходимо установить оба (или любой) из блоков errorBlock и successBlock, которые вернут NSError * или соответственно JSON объект ответа сервера (NSDictionary *).

Осуществление запроса на получение списка друзей и вывод ответа сервера в консоль (сразу после авторизации пользователем приложения) может выглядеть таким образом:
````objective-c
[twitter startOnCancelBlock:^{

} onErrorBlock:^(NSError *error) {

} onSuccessBlock:^(DPTwitterUserAccount *account) {          
  [account setSuccessBlock:^(NSDictionary *dictionary) {
    NSLog(@"Friends :%@", dictionary);
  }];
            
  [account obtainFriendsWithCursor:@"-1"];
   
}];
````

## DPTwitterUserAccount
Для работы с классом необходимо произвести инициализацию используя следующий метод:
````objective-c
-(id)initWithToken:(NSString *)token
       tokenSecret:(NSString *)tokenSecret
     twitterUserID:(NSString *)userId
    userScreenName:(NSString *)screenName;
````

Следующим шагом будет установка одного или обоих блоков обработчиков (onError и onSuccess):
````objective-c
[account setSuccessBlock:^(NSDictionary *dictionary){
     NSLog(@"response from server = %@", dictionary);
}];
````

После предварительной установки блоков мы отправляем объекту необходимое сообщение вроде получение информации о текущем пользователе или списка его фолловеров:
````objective-c
[account obtainFollowersWithCursor:@"-1"];
````

**Список запросов, которые можно осуществить от лица текущего пользователя:**

Примечание: _Методы, которые получают словарь NSDictionary* и чьи имена заканчиваются на WithCustomOptions принимают все те параметры и любые их корректные конфигурации, которые указаны на страницах документации твиттера по данному методу._

* Метод осуществляет **тестовый** запрос для проверки действительности access_token пользователя ( данная проверка может потребоваться в случае, если пользователь сперва авторизовал наше приложение, а затем осуществил операцию отключения доступа приложения к своему аккаунту непосредственно через Твиттер, в то время, как у нас сохранился access_token и прочие данные )
````objective-c
- (BOOL)isAuthorized;
````

* Получение информации и текущем пользователе: https://dev.twitter.com/docs/api/1.1/get/users/show
````objective-c
- (void)obtainInfo;
````

* Получение списка настроек текущего пользователя: https://dev.twitter.com/docs/api/1.1/get/account/settings
````objective-c
- (void)obtainSettings;
````

* Проверка на авторизованность текущего пользователя: https://dev.twitter.com/docs/api/1.1/get/account/verify_credentials
````objective-c
- (void)verifyCredentials;
- (void)verifyCredentialsWithCustomOptions:(NSDictionary *)options;
````

* Произвести настройку пользовательского аккаунта: https://dev.twitter.com/docs/api/1.1/post/account/update_profile
````objective-c
- (void)updateProfileWithCustomOptions:(NSDictionary *)options;
````

* Получение списка друзей используя указатель: https://dev.twitter.com/docs/api/1.1/get/friends/list
````objective-c
- (void)obtainFriendsWithCursor:(NSString *)cursor;
- (void)obtainFriendsWithCustomOptions:(NSDictionary *)options;
````

* Получение списка фолловеров: https://dev.twitter.com/docs/api/1.1/get/followers/list
````objective-c
- (void)obtainFollowersWithCursor:(NSString *)cursor;
- (void)obtainFollowersWithCursorWithCustomOptions:(NSDictionary *)options;
````

* Запрос информации о пользователе указанном в передаваемом параметре: https://dev.twitter.com/docs/api/1.1/get/users/show
````objective-c
- (void)showInfoForUserId:(NSString *)userId;
- (void)showInfoForUserScreenName:(NSString *)screenName;
- (void)showInfoForUserWithCustomOptions:(NSDictionary *)options;
````

* Получение списка заблокированных пользователей, разблокирование пользователя: https://dev.twitter.com/docs/api/1.1/get/blocks/ids , https://dev.twitter.com/docs/api/1.1/post/blocks/create
````objective-c
- (void)obtainUsersInBlock;
- (void)obtainUsersInBlockCursor:(NSString *)cursor;
- (void)blockUserId:(NSString *)userId;
- (void)blockUserScreenName:(NSString *)screenName;
- (void)blockUserWithCustomOptions:(NSDictionary *)options;
- (void)unblockUserId:(NSString *)userId;
- (void)unblockUserScreenName:(NSString *)screenName;
- (void)unblockUserWithCustomOptions:(NSDictionary *)options;
````

* Получение личных сообщений пользователя: https://dev.twitter.com/docs/api/1.1/get/direct_messages
````objective-c
- (void)obtainDirectMessages;
- (void)obtainDirectMessageId:(NSString *)directMessageId;
- (void)obtainDirectMessagesCount:(NSUInteger)count;
- (void)obtainDirectMessagesSinceId:(NSString *)sinceId;
- (void)obtainDirectMessagesCustomOptions:(NSDictionary *)options;
````

* Получение отправленных пользователем сообщений: https://dev.twitter.com/docs/api/1.1/get/direct_messages/sent
````objective-c
- (void)obtainSentDirectMessages;
- (void)obtainSentDirectMessagesCount:(NSUInteger)count;
- (void)obtainSentDirectMessagesSinceId:(NSString *)sinceId;
- (void)obtainSentDirectMessagesPage:(NSUInteger)page;
- (void)obtainSentDirectMessagesCustomOptions:(NSDictionary *)options;
````

* Удаление личных сообщений: https://dev.twitter.com/docs/api/1.1/post/direct_messages/destroy
````objective-c
- (void)destroyDirectMessageId:(NSString *)directMessageId;
- (void)destroyDirectMessageCustomOptions:(NSDictionary *)options;
````

* Постинг твитта: https://dev.twitter.com/docs/api/1/post/statuses/update
````objective-c
- (void)tweet:(NSString *)text;
- (void)tweetWithCustomOptions:(NSDictionary *)options;
````

* Удаление твитта: https://dev.twitter.com/docs/api/1.1/post/direct_messages/destroy
````objective-c
- (void)destroyTweetId:(NSString *)tweetId;
````

* Отправка личного сообщения: https://dev.twitter.com/docs/api/1.1/post/direct_messages/new
````objective-c
- (void)sendDirectMessage:(NSString *)msg userId:(NSString *)userId;
- (void)sendDirectMessage:(NSString *)msg userScreenName:(NSString *)screenName;
````


## DPVkontakteCommunicator

Класс используемый для получения доступа к пользовательскому аккаунту VK.com.

**Как использовать?**

Сперва необходимо подключить заголовочные файлы:
````objective-c
#import "DPVkontakteCommunicator.h"
#import "DPVkontakteUserAccount.h"
````

В заголовочном файле DPVkontakteCommunicator заменить значения ключей приложения на свои: VKONTAKTE_APP_ID, VKONTAKTE_PRIVATE_KEY, VKONTAKTE_PERMISSIONS_LIST. 
Последний параметр содержит в себе список объектов к которым необходимо получить доступ.

Для инициализации класса DPVkontakteCommunicator используем следующий метод:
````objective-c
- (id)initWithWebView:(UIWebView *)webView;
````

После инициализации класса вызываем следующий метод:
````objective-c
- (void)startOnCancelBlock:(void (^)(void))cancelBlock
              onErrorBlock:(void (^)(NSError *))errorBlock
            onSuccessBlock:(void (^)(DPVkontakteUserAccount *))acceptedBlock;
````
Именно этот метод производит инициализацию запроса, именно после вызова этого метода начинается работа по получению пользовательского access_token.

Пример работы с классами DPVkontakteCommunicator и DPVkontakteUserAccount:
````objective-c
- (void)viewDidLoad {
    [super viewDidLoad];

    CGRect frame = [[UIScreen mainScreen] bounds];
    _webView = [[UIWebView alloc] initWithFrame:frame];
    [_webView setHidden:NO];
    [self.view addSubview:_webView];

    _vk = [[DPVkontakteCommunicator alloc] initWithWebView:_webView];

    [_vk startOnCancelBlock:^{
        NSLog(@"Cancel");
    } onErrorBlock:^(NSError *error) {
        NSLog(@"Error: %@", error);
    } onSuccessBlock:^(DPVkontakteUserAccount *account) {
        NSLog(@"account:%@", account);

        [account setSuccessBlock:^(NSDictionary *dictionary)
        {
            NSLog(@"response: %@", dictionary);
        }];

        [account sendPrivateMessage:@"Testring iOS DPSocialServices!"
                 toUserId:@"58487857"];
    }];
}
````

## DPVkontakteUserAccount

Инициализация пользовательского класса DPVkontakteUserAccount производится с использованием следующего метода:
````objective-c
- (id)initUserAccountWithAccessToken:(NSString *)accessToken
                      expirationTime:(NSUInteger)expirationTime
                              userId:(NSUInteger)userId;
````

либо так:
````objective-c
- (id)initUserAccountWithAccessToken:(NSString *)accessToken
                              userId:(NSUInteger)userId;
````

После инициализации можно осуществлять запросы от имени текущего пользователя. Запросы будут осуществлены, но никак не обработаны.
Для их обработки необходимо установить блок successBlock. Установка блока errorBlock остается на усмотрение программиста.

Пример осуществления запрос и обработки результата:
````objective-c
DPVkontakteUserAccount *me = // alloc + init;

[me setSuccessBlock:^(NSDictionary *response){
    NSLog(@"server response = %@", response);
}];

[me obtainInfo];
````

**Список запросов, которые можно осуществить от лица пользователя**

* Получение информации о пользователе. Метод сервера к которому происходит запрос: users.get ( https://vk.com/dev/users.get )
````objective-c
- (void)obtainInfo;
````

* Осуществление запроса на получение пользовательской информации с переданной конфигурацией. Конфигурация подразумевает собой набор ключей и их значений, которые описаны в документации ВК по данному методу. Метод сервера к которому происходит запрос: users.get ( https://vk.com/dev/users.get )
````objective-c
- (void)obtainInfoWithCustomOptions:(NSDictionary *)options;
````

* Получение информации о пользователе с указанным идентификатором. Метод сервера к которому происходит запрос: users.get ( https://vk.com/dev/users.get )
````objective-c
- (void)obtainInfoForUser:(NSString *)userId;
````

* Отправка сообщения message пользователю с идентификатором userId. Метод сервера к которому происходит запрос: messages.send ( https://vk.com/dev/messages.send )
````objective-c
- (void)sendPrivateMessage:(NSString *)message
                  toUserId:(NSString *)userId;
````

* Отправка сообщения message с прикрепленной фотографией ( путь к фотографии photoPath ) пользователю с идентификатором userId. Метод сервера к которому происходит запрос: messages.send ( https://vk.com/dev/messages.send )
''Примечание: для отправки сообщения с большим кол-вом фотографий используйте метод uploadPhoto в связке с sendPrivateMessageWithCustomOptions:''
````objective-c
- (void)sendPrivateMessage:(NSString *)message
                     photo:(NSString *)photoPath
                  toUserId:(NSString *)userId;
````

* Отправка сообщения с произвольными параметрами. Список параметров можно найти в документации: https://vk.com/dev/messages.send
````objective-c
- (void)sendPrivateMessageWithCustomOptions:(NSDictionary *)options;
````

* Постинг записи на стену пользователя (только текстовая информация). Метод сервера к которому происходит запрос: wall.post ( https://api.vk.com/method/wall.post )
````objective-c
- (void)postToWall:(NSString *)text; 
````

* Постинг записи на стену пользователя с расширенными опциями. Метод сервера к которому происходит запрос: wall.post ( https://api.vk.com/method/wall.post )
````objective-c
- (void)postToWallWithCustomOptions:(NSDictionary *)options;
````

* Загружает указанную фотографию на сервер ВК. Для осуществления данного запроса используется последовательность из 3 последовательных подзапросов. Детальнее метод загрузки фотографии на сервера ВК описан по этой ссылке: https://vk.com/page-1_2372787
````objective-c
- (void)uploadPhoto:(NSString *)photoPath;
````

* Получение списка последних count отправленных пользовательских сообщений. Метод сервера к которому происходит запрос: messages.get ( https://api.vk.com/method/messages.get )
````objective-c
- (void)obtainLastSentMessagesCount:(NSUInteger)count;
````

* Получение списка последних count отправленных пользовательских сообщений со смещением offset. Метод сервера к которому происходит запрос: messages.get ( https://api.vk.com/method/messages.get  )
````objective-c
- (void)obtainLastSentMessagesCount:(NSUInteger)count offset:(NSUInteger)offset;
````

* Получение списка отправленных пользовательских сообщений с указанными опциями. Описания опций смотреть в докуменетации ВК по описанию метода messages.get ( https://vk.com/dev/messages.get ). 
````objective-c
- (void)obtainLastMessagesWithCustomOptions:(NSDictionary *)options;
````

* Получение списка из count последних отправленных и непрочитанных сообщений пользователя. Метод сервера к которому происходит запрос: messages.get ( https://api.vk.com/method/messages.get )
````objective-c
- (void)obtainLastSentUnreadMessagesCount:(NSUInteger)count;
````

* Получение списка из count последних отправленных и непрочитанных сообщений пользователя со смещением offset. Метод сервера к которому происходит запрос: messages.get ( https://api.vk.com/method/messages.get )
````objective-c
- (void)obtainLastSentUnreadMessagesCount:(NSUInteger)count
                                             offset:(NSUInteger)offset;
````

* Возвращает историю сообщений с пользователем, идентификатор которого передается методу. Метод сервера к которому происходит запрос: messages.getHistory ( https://vk.com/dev/messages.getHistory )
````objective-c
- (void)obtainDialogMessagesWithUser:(NSString *)userId;
````

* Возвращает историю сообщений (последние count сообщений) с пользователем, идентификатор которого передается методу. Метод сервера к которому происходит запрос: messages.getHistory ( https://vk.com/dev/messages.getHistory )
````objective-c
- (void)obtainDialogMessagesWithUser:(NSString *)userId
                                     count:(NSUInteger)count;
````

* Возвращает историю сообщений (кол-во сообщений count и со смещением offset) с пользователем, идентификатор которого передается методу. Метод сервера к которому происходит запрос: messages.getHistory ( https://vk.com/dev/messages.getHistory )
````objective-c
- (void)obtainDialogMessagesWithUser:(NSString *)userId
                               count:(NSUInteger)count
                              offset:(NSUInteger)offset;
````

* Возвращает историю сообщений с пользователем, которой будет указан в словаре опций. Метод сервера к которому происходит запрос: messages.getHistory ( https://vk.com/dev/messages.getHistory )
````objective-c
- (void)obtainDialogMessagesWithCustomOptions:(NSDictionary *)options;
````

* Получаем список друзей пользователя. Метод сервера к которому происходит запрос: friends.get ( https://vk.com/dev/friends.get )
````objective-c
- (void)obtainFriends;
````

* Получаем список из count первых друзей пользователя отсортированных в алфавитном порядке. Метод сервера к которому происходит запрос: friends.get ( https://vk.com/dev/friends.get )
````objective-c
- (void)obtainFriendsCount:(NSUInteger)count;
````

* Получаем список из count первых друзей пользователя со смещением offset отсортированных в алфавитном порядке. Метод сервера к которому происходит запрос: friends.get ( https://vk.com/dev/friends.get )
````objective-c
- (void)obtainFriendsCount:(NSUInteger)count offset:(NSUInteger)offset;
````

* Получение списка друзей с произвольными настройками. Со списком возможных настроек/опций можно ознакомиться на странице https://vk.com/dev/friends.get
````objective-c
- (void)obtainFriendsWithCustomOptions:(NSDictionary *)options;
````

* Возвращает список идентификаторов пользователей и групп, которые входят в список подписок пользователя. Метод сервера ВК к которому происходит запрос: users.getSubscriptions ( https://vk.com/dev/users.getSubscriptions )
````objective-c
- (void)obtainSubscriptions;
````

* Возвращает список идентификаторов пользователей, которые являются подписчиками пользователя. Идентификаторы пользователей в списке отсортированы в порядке убывания времени их добавления. Метод сервера к которому происходит запрос: users.getFollowers ( https://vk.com/dev/users.getFollowers )
````objective-c
- (void)obtainFollowers;
````

* Получение списка из count идентификаторов пользователей, которые являются подписчиками текущего пользователя. Метод сервера к которому происходит запрос: users.getFollowers ( https://vk.com/dev/users.getFollowers )
````objective-c
- (void)obtainFollowersCount:(NSUInteger)count;
````

* Получение списка из count идентификаторов пользователей со смешением offset, которые являются подписчиками текущего пользователя. Метод сервера к которому происходит запрос: users.getFollowers ( https://vk.com/dev/users.getFollowers )
````objective-c
- (void)obtainFollowersCount:(NSUInteger)count offset:(NSUInteger)offset;
````

* Получение списка идентификатором пользователей, которые являются подписчиками текущего пользователя. В параметре options передаются параметры запроса с которыми можно ознакомиться по ссылке: https://vk.com/dev/users.getFollowers
````objective-c
- (void)obtainFollowersWithCustomOptions:(NSDictionary *)options;
````
