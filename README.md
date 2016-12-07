
# xl-cml-gen

Simple library to generate XML-like documents

## Rationale

Library is supposed to provide a super simple way to generate markup inspired
by [hiccup](https://github.com/weavejester/hiccup) library.

## API

Every element is represented as a list, where first element (which can be a keyword, a symbol or a string)
is a tag name, second argument is a alist with attributes and the rest arguments are child elements of
the element. If there are any lists there they will be merged on one level with others.

    (xml '(:div (:class "news-feed")
                (:h1 (:class "news-feed__title") "News feed")
                (:p nil "News item")))

    <div class="news-feed">
      <h1 class="news-feed__title">News feed</h1>
      <p>News item</p>
    </div>

## License

All the code except any parts taken from original dpans-parser project and spec itself are in
Public Domain. Enjoy!
