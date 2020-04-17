'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "index.html": "105ea8efb4e529130c1541a4c0f3f714",
"/": "105ea8efb4e529130c1541a4c0f3f714",
"main.dart.js": "71da143a46aafd0a3f4ccde9d3df791a",
"favicon.png": "eb4d03368f2a198f65e5e42dc2cbe88a",
"icons/Icon-192.png": "eef67ecba3ee44d352066c71a02d82d0",
"icons/Icon-512.png": "81f9128948f0295b4327582ce441ba40",
"manifest.json": "1c4cf070c3a3e0fcd7b877e0fce00f6e",
"assets/LICENSE": "73478a60f35a7a7d72ef1b73b7f7b98e",
"assets/AssetManifest.json": "0a3e1f59acf8a60cb54f056630c4ff77",
"assets/sounds/bell5.mp3": "90ed5fb9f165f32aab3224713c2556da",
"assets/sounds/bell1.mp3": "fab6a136dd9de2be90f2f040949e85a0",
"assets/FontManifest.json": "01700ba55b08a6141f33e168c4a6c22f",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request);
      })
  );
});
