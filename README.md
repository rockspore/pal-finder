# Invite

- If you wanna find someone to meet and go eat at your favorite restaurants
- If you are new to this place or just wanna discover some new restaurants nearby

**Invite** is here to help. Invite lets you invite a new friend to go to a restaurant with. Or you can also swipe through nearby invites to find great new places to go to with a host you like!

## Demo
![demo](demo/invite_demo.gif)

## Backend
This repo is the modile side of Invite, checkout the [backend](https://github.com/archelangelo/eventplus).

## Set up Google Places API keys

We use `./.env` file to set up the API Key. (**KEEP `.env` FILE PRIVATE**). Since the API key will ship with the package, we need to restrict the key usage from only our app by signing the app.

Go to your Google Cloud Platform Console and head to *APIs & Services -> Credentials* page. Click *Create credentials* and select *API key*. You should click *RESTRICT KEY* button and set up appropriate API key restrictions.

Create `./.env` and put this line in it:
```
PLACES_API_KEY=<Your Google Places API Key>
```
