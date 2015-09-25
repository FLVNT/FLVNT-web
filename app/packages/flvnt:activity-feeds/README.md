flvnt:activity-feeds
====================

activity-streams package for meteor.js apps.



## overview: specification

based on the JSON Activity Streams 1.0 specification.

- see: http://activitystrea.ms/specs/json/1.0/
- see: https://en.wikipedia.org/wiki/Activity_Streams_(format)
- see: http://www.w3.org/TR/activitystreams-core/


activities are important in that they allow individuals to process the latest
news of people and things they care about.

in its simplest form, an `activity` consists of: `actor`, `verb`, `object`, `target`.
it tells the story of a person performing an action on or with an object


an `Activity Stream` is a collection one or more individual activities. the
relationship between the activities within the collection is defined by the
implementation of the app.



### example `activity` object:

    {
      "published": "2011-02-10T15:04:55Z",
      "actor": {
        "url": "http://example.org/martin",
        "objectType" : "person",
        "id": "tag:example.org,2011:martin",
        "image": {
          "url": "http://example.org/martin/image",
          "width": 250,
          "height": 250
        },
        "displayName": "Martin Smith"
      },
      "verb": "post",
      "object" : {
        "url": "http://example.org/blog/2011/02/entry",
        "id": "tag:example.org,2011:abc123/xyz"
      },
      "target" : {
        "url": "http://example.org/blog/",
        "objectType": "blog",
        "id": "tag:example.org,2011:abc123",
        "displayName": "Martin's Blog"
      }
    }



### properties:


#### `actor`
describes the entity that performed the activity.


#### `object`
describes the primary object of the activity. for instance, in the activity,
"`John saved a movie to his wishlist`", the object of the activity is "`movie`".


#### `target`
describes the target of the `activity`. the precise meaning of the activity's
target is dependent on the activity's `verb`, but will often be the object
the english preposition "to". for instance, in the activity:
"`john saved a movie to his wishlist`", the target of the activity is "`wishlist`".
the activity target must not be used to identity an indirect object that is
not a target of the activity.


#### `published`
date and time at which the activity was published.


#### `verb`
identifies the action that the activity describes.

