//
// Created by AndrewShmig on 5/6/13.
//
// Copyright (c) AndrewShmig. All rights reserved.
//

/*
* Oauth
* */
static NSString *const kTWITTER_OAUTH_REQUEST_TOKEN_URL = @"https://api.twitter.com/oauth/request_token";
static NSString *const kTWITTER_OAUTH_AUTHENTICATE_URL = @"https://api.twitter.com/oauth/authenticate";
static NSString *const kTWITTER_OAUTH_AUTHORIZE_URL = @"https://api.twitter.com/oauth/authorize";
static NSString *const kTWITTER_OAUTH_ACCESS_TOKEN_URL = @"https://api.twitter.com/oauth/access_token";

/*
* Timelines
* */
static NSString *const kTWITTER_STATUSES_MENTIONS_TIMELINE_URL = @"https://api.twitter.com/1.1/statuses/mentions_timeline"; // GET
static NSString *const kTWITTER_STATUSES_USER_TIMELINE_URL = @"https://api.twitter.com/1.1/statuses/user_timeline"; // GET
static NSString *const kTWITTER_STATUSES_HOME_TIMELINE_URL = @"https://api.twitter.com/1.1/statuses/home_timeline"; // GET
static NSString *const kTWITTER_STATUSES_RETWEETS_OF_ME_URL = @"https://api.twitter.com/1.1/statuses/retweets_of_me"; // GET

/*
* Tweets
* */
static NSString *const kTWITTER_STATUSES_RETWEETS_ID_URL = @"https://api.twitter.com/1.1/statuses/retweets/:id"; // GET
static NSString *const kTWITTER_STATUSES_SHOW_ID_URL = @"https://api.twitter.com/1.1/statuses/show/:id"; // GET
static NSString *const kTWITTER_STATUSES_DESTROY_ID_URL = @"https://api.twitter.com/1.1/statuses/destroy/:id"; // POST
static NSString *const kTWITTER_STATUSES_UPDATE_URL = @"https://api.twitter.com/1.1/statuses/update"; // POST
static NSString *const kTWITTER_STATUSES_RETWEET_ID_URL = @"https://api.twitter.com/1.1/statuses/retweet/:id"; // POST
static NSString *const kTWITTER_STATUSES_UPDATE_WITH_MEDIA_URL = @"https://api.twitter.com/1.1/statuses/update_with_media"; // POST
static NSString *const kTWITTER_STATUSES_OEMBED_URL = @"https://api.twitter.com/1.1/statuses/oembed"; // GET

/*
* Search
* */
static NSString *const kTWITTER_SEARCH_TWEETS_URL = @"https://api.twitter.com/1.1/search/tweets"; // GET

/*
* Streaming
* */
static NSString *const kTWITTER_STATUSES_FILTER_URL = @"https://api.twitter.com/1.1/statuses/filter"; // POST
static NSString *const kTWITTER_STATUSES_SAMPLE_URL = @"https://api.twitter.com/1.1/statuses/sample"; // GET
static NSString *const kTWITTER_STATUSES_FIREHOSE_URL = @"https://api.twitter.com/1.1/statuses/firehose"; // GET
static NSString *const kTWITTER_STREAMING_USER_URL = @"https://api.twitter.com/1.1/user"; // GET
static NSString *const kTWITTER_STREAMING_SITE_URL = @"https://api.twitter.com/1.1/site"; // GET

/*
* Direct messages
* */
static NSString *const kTWITTER_DERECT_MESSAGES_URL = @"https://api.twitter.com/1.1/direct_messages"; // GET
static NSString *const kTWITTER_DIRECT_MESSAGES_SENT_URL = @"https://api.twitter.com/1.1/direct_messages/sent"; // GET
static NSString *const kTWITTER_DIRECT_MESSAGES_SHOW_URL = @"https://api.twitter.com/1.1/direct_messages/show"; // GET
static NSString *const kTWITTER_DIRECT_MESSAGES_DESTROY_URL = @"https://api.twitter.com/1.1/direct_messages/destroy"; // POST
static NSString *const kTWITTER_DIRECT_MESSAGES_NEW_URL = @"https://api.twitter.com/1.1/direct_messages/new"; // POST

/*
* Friends & Followers
* */
static NSString *const kTWITTER_FRIENDSHIPS_NO_RETWEETS_IDS_URL = @"https://api.twitter.com/1.1/friendships/no_retweets/ids"; // GET
static NSString *const kTWITTER_FRIENDS_IDS_URL = @"https://api.twitter.com/1.1/friends/ids"; // GET
static NSString *const kTWITTER_FOLLOWERS_IDS_URL = @"https://api.twitter.com/1.1./followers/ids"; // GET
static NSString *const kTWITTER_FRIENDSHIPS_LOOKUP_URL = @"https://api.twitter.com/1.1/friendships/ids"; // GET
static NSString *const kTWITTER_FRIENDSHIPS_INCOMING_URL = @"https://api.twitter.com/1.1/friendships/incoming"; // GET
static NSString *const kTWITTER_FRIENDSHIPS_OUTGOING_URL = @"https://api.twitter.com/1.1/friendships/outgoing"; // GET
static NSString *const kTWITTER_FRIENDSHIPS_CREATE_URL = @"https://api.twitter.com/1.1/friendships/create"; // POST
static NSString *const kTWITTER_FRIENDSHIPS_DESTROY_URL = @"https://api.twitter.com/1.1/friendships/destroy"; // POST
static NSString *const kTWITTER_FRIENDSHIPS_UPDATE_URL = @"https://api.twitter.com/1.1/friendships/update"; // POST
static NSString *const kTWITTER_FRIENDSHIPS_SHOW_URL = @"https://api.twitter.com/1.1/friendships/show"; // GET
static NSString *const kTWITTER_FRIENDS_LIST_URL = @"https://api.twitter.com/1.1/friends/list"; // GET
static NSString *const kTWITTER_FOLLOWERS_LIST_URL = @"https://api.twitter.com/1.1/followers/list"; // GET

/*
* Users
* */
static NSString *const kTWITTER_ACCOUNT_SETTINGS_URL = @"https://api.twitter.com/1.1/account/settings"; // GET
static NSString *const kTWITTER_ACCOUNT_VERIFY_CREDENTIALS_URL = @"https://api.twitter.com/1.1/account/verify_credentials"; // GET
static NSString *const kTWITTER_ACCOUNT_SETTINGS_UPDATE_URL = @"https://api.twitter.com/1.1/account/settings"; // POST
static NSString *const kTWITTER_ACCOUNT_UPDATE_DELIVERY_DEVICE_URL = @"https://api.twitter.com/1.1/account/update_delivery_device"; // POST
static NSString *const kTWITTER_ACCOUNT_UPDATE_PROFILE_URL = @"https://api.twitter.com/1.1/account/update_profile"; // POST
static NSString *const kTWITTER_ACCOUNT_UPDATE_PROFILE_BACKGROUND_IMAGE_URL = @"https://api.twitter.com/1.1/account/update_profile_background_picture"; // POST
static NSString *const kTWITTER_ACCOUNT_UPDATE_PROFILE_COLORS_URL = @"https://api.twitter.com/1.1/account/update_profile_colors"; // POST
static NSString *const kTWITTER_ACCOUNT_UPDATE_RROFILE_IMAGE_URL = @"https://api.twitter.com/1.1/account/update_profile_image"; // POST
static NSString *const kTWTITTER_BLOCKS_LIST_URL = @"https://api.twitter.com/1.1/blocks/list"; // GET
static NSString *const kTWITTER_BLOCKS_IDS_URL = @"https://api.twitter.com/1.1/blocks/ids"; // GET
static NSString *const kTWITTER_BLOCKS_CREATE_URL = @"https://api.twitter.com/1.1/blocks/create"; // POST
static NSString *const kTWITTER_BLOCKS_DESTROY_URL = @"https://api.twitter.com/1.1/blocks/destroy"; // POST
static NSString *const kTWITTER_USERS_LOOKUP_URL = @"https://api.twitter.com/1.1/users/lookup"; // GET
static NSString *const kTWITTER_USERS_SHOW_URL = @"https://api.twitter.com/1.1/users/show"; // GET
static NSString *const kTWITTER_USERS_SEARCH_URL = @"https://api.twitter.com/1.1/users/search"; // GET
static NSString *const kTWITTER_USERS_CONTRIBUTEES_URL = @"https://api.twitter.com/1.1/users/contributees"; // GET
static NSString *const kTWITTER_USERS_CONTRIBUTORS_URL = @"https://api.twitter.com/1.1/users/contributors"; // GET
static NSString *const kTWITTER_ACCOUNT_REMOVE_PROFILE_BANNER_URL = @"https://api.twitter.com/1.1/account/remove_profile_banner"; // POST
static NSString *const kTWITTER_ACCOUNT_UPDATE_PROFILE_BANNER_URL = @"https://api.twitter.com/1.1/account/update_profile_banner"; // POST
static NSString *const kTWITTER_USERS_PROFILE_BANNER_URL = @"https://api.twitter.com/1.1/users/profile_banner"; // GET

/*
* Suggested users
* */
static NSString *const kTWITTER_USERS_SUGGESTIONS_SLUG_URL = @"https://api.twitter.com/1.1/users/suggestions/:slug"; // GET
static NSString *const kTWITTER_USERS_SUGGESTIONS_URL = @"https://api.twitter.com/1.1/users/suggestions"; // GET
static NSString *const kTWITTER_USERS_SUGGESTIONS_SLUG_MEMBERS_URL = @"https://api.twitter.com/1.1/users/suggestions/:slug/members"; // GET

/*
* Favourites
* */
static NSString *const kTWITTER_FAVOURITES_LIST_URL = @"https://api.twitter.com/1.1/favourites/list"; // GET
static NSString *const kTWITTER_FAVOURITES_DESTROY_URL = @"https://api.twitter.com/1.1/favourites/destroy"; // POST
static NSString *const kTWITTER_FAVOURITES_CREATE_URL = @"https://api.twitter.com/1.1/favourites/create"; // POST

/*
* Lists
* */
static NSString *const kTWITTER_LISTS_LIST_URL = @"https://api.twitter.com/1.1/lists/list"; // GET
static NSString *const kTWITTER_LISTS_STATUSES_URL = @"https://api.twitter.com/1.1/lists/statuses"; // GET
static NSString *const kTWITTER_LISTS_MEMBERS_DESTROY_URL = @"https://api.twitter.com/1.1/lists/members/destroy"; // GET
static NSString *const kTWITTER_LISTS_MEMBERSHIPS_URL = @"https://api.twitter.com/1.1/lists/memberships"; // GET
static NSString *const kTWITTER_LISTS_SUBSCRIBERS_URL = @"https://api.twitter.com/1.1/lists/subscribers"; // GET
static NSString *const kTWITTER_LISTS_SUBSCRIBERS_CREATE_URL = @"https://api.twitter.com/1.1/lists/subscribers/create"; // POST
static NSString *const kTWITTER_LISTS_SUBSCRIBERS_SHOW_URL = @"https://api.twitter.com/1.1/lists/subscribers/show"; // GET
static NSString *const kTWITTER_LISTS_SUBSCRIBERS_DESTROY_URL = @"https://api.twitter.com/1.1/lists/subscribers/destroy"; // POST
static NSString *const kTWITTER_LISTS_MEMBERS_CREATE_ALL_URL = @"https://api.twitter.com/1.1/lists/members/create_all"; // POST
static NSString *const kTWITTER_LISTS_MEMBERS_SHOW_URL = @"https://api.twitter.com/1.1/lists/members/show"; // GET
static NSString *const kTWITTER_LISTS_MEMBERS_URL = @"https://api.twitter.com/1.1/lists/members"; // GET
static NSString *const kTWITTER_LISTS_MEMBERS_CREATE_URL = @"https://api.twitter.com/1.1/lists/members/create"; // POST
static NSString *const kTWITTER_LISTS_DESTROY_URL = @"https://api.twitter.com/1.1/lists/destroy"; // POST
static NSString *const kTWITTER_LISTS_UPDATE_URL = @"https://api.twitter.com/1.1/lists/update"; // POST
static NSString *const kTWITTER_LISTS_CREATE_URL = @"https://api.twitter.com/1.1/lists/create"; // POST
static NSString *const kTWITTER_LISTS_SHOW_URL = @"https://api.twitter.com/1.1/lists/show"; // GET
static NSString *const kTWITTER_LISTS_SUBSCRIPTIONS_URL = @"https://api.twitter.com/1.1/lists/subscriptions"; // GET
static NSString *const kTWITTER_LISTS_MEMBERS_DESTROY_ALL_URL = @"https://api.twitter.com/1.1/lists/members/destroy_all"; // POST
static NSString *const kTWITTER_LISTS_OWNERSHIPS_URL = @"https://api.twitter.com/1.1/lists/ownerships"; // GET

/*
* Saved searches
* */
static NSString *const kTWITTER_SAVED_SEARCHES_LIST_URL = @"https://api.twitter.com/1.1/saved_searches/list"; // GET
static NSString *const kTWITTER_SAVED_SEARCHES_SHOW_ID_URL = @"https://api.twitter.com/1.1/saved_searches/show/:id"; // GET
static NSString *const kTWITTER_SAVED_SEARCHES_CREATE_URL = @"https://api.twitter.com/1.1/saved_searches/create"; // POST
static NSString *const kTWITTER_SAVED_SEARCHES_DESTROY_ID_URL = @"https://api.twitter.com/1.1/saved_searches/destroy/:id"; // POST

/*
* Places & Geo
* */
static NSString *const kTWITTER_GEO_ID_PLACE_ID_URL = @"https://api.twitter.com/1.1/geo/id/:place_id"; // GET
static NSString *const kTWITTER_GEO_REVERSE_GEOCODE_URL = @"https://api.twitter.com/1.1/geo/reverse_geocode"; // GET
static NSString *const kTWITTER_GEO_SEARCH_URL = @"https://api.twitter.com/1.1/geo/search"; // GET
static NSString *const kTWITTER_GEO_SIMILAR_PLACES_URL = @"https://api.twitter.com/1.1/geo/similar_places"; // GET
static NSString *const kTWITTER_GEO_PLACE_CREATE_URL = @"https://api.twitter.com/1.1/geo/place"; // POST

/*
* Trends
* */
static NSString *const kTWITTER_TRENDS_PLACES_URL = @"https://api.twitter.com/1.1/trends/places"; // GET
static NSString *const kTWITTER_TRENDS_AVAILABLE_URL = @"https://api.twitter.com/1.1/trends/available"; // GET
static NSString *const kTWITTER_TRENDS_CLOSEST_URL = @"https://api.twitter.com/1.1/trends/closest"; // GET

/*
* Spam reporting
* */
static NSString *const kTWITTER_USERS_REPORT_SPAM_URL = @"https://api.twitter.com/1.1/users/report_spam"; // POST

/*
* Help
* */
static NSString *const kTWITTER_HELP_CONFIGURATION_URL = @"https://api.twitter.com/1.1/help/configuration"; // GET
static NSString *const kTWITTER_HELP_LANGUAGES_URL = @"https://api.twitter.com/1.1/help/languages"; // GET
static NSString *const kTWITTER_HELP_PRIVACY_URL = @"https://api.twitter.com/1.1/help/privacy"; // GET
static NSString *const kTWITTER_HELP_TOS_URL = @"https://api.twitter.com/1.1/help/tos"; // GET
static NSString *const kTWITTER_APPLICATION_RATE_LIMIT_STATUS = @"https://api.twitter.com/1.1/application/rate_limit_status"; // GET
