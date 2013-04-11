# ASASocialServices

[Основная директория](https://github.com/AndrewShmig/ASASocialServices/tree/master/DPSocialServices/DPSocialServices/SocialServices) модуля.

* [Как использовать DPSocialServices с Twitter](https://github.com/AndrewShmig/ASASocialServices/wiki/Twitter).


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
