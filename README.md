# ASASocialServices

Набор классов ASASocialServices предназначен для взаимодействия с социальными сетями:
* Twitter [status: paused]
  * [Как настроить?](https://github.com/AndrewShmig/ASASocialServices/wiki/DPTwitterCommunicator)
  * [Как осуществлять запросы?](https://github.com/AndrewShmig/ASASocialServices/wiki/DPTwitterUserAccount)
* Vkontakte [status: in progress]
  * Как работать с библиотекой?
  * Как настроить?
  * Как получить access_token пользователя ?
  * Как осуществлять запросы?
  * Примеры запросов.
     * Получение списка друзей
     * Отправка личного сообщения определенному пользователю
     * Постинг на стену
     * т.д.
  * Как загрузить документ?
  * Как загрузить аудио?
  * Как загрузить видео?
* Facebook
  * [Как настроить?](https://github.com/AndrewShmig/ASASocialServices/wiki/DPFacebookCommunicator)
  * [Как осуществлять запросы?](https://github.com/AndrewShmig/ASASocialServices/wiki/DPFacebookUserAccount)
  * [Пример постинга в ленту пользователя](https://github.com/AndrewShmig/ASASocialServices/wiki/%5BUserGuide%5D-Как-осуществить-постинг-в-ленту-пользователя-Facebook)
  * [Пример получения списка друзей](https://github.com/AndrewShmig/ASASocialServices/wiki/%5BUserGuide%5D-Как-получить-список-друзей-пользователя-Facebook)
  * [Пример получения списка друзей пользователя с определенными данными](https://github.com/AndrewShmig/ASASocialServices/wiki/%5BUserGuide%5D-Как-получить-список-друзей-пользователя-Facebook-с-определенной-иформацией)

Детальная информация находится на [страницах](https://github.com/AndrewShmig/ASASocialServices/wiki/_pages).

Класс ASA*Communicator позволяет получить все необходимые токены для осуществления дальнейших запросов от лица пользователя, которые производятся через класс ASA*UserAccount.
