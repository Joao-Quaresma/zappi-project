```
Ruby        2.3.3
Bundler     1.17.1
Rails       4.2.5
Mysql       Ver 14.14 Distrib 5.6.35
```

```
This app allows users to:
- Register / login
- Create Wikis
- Create Announcements
- Create FAQ's
- Create Posts (similar to Instagram)
- Like / Dislike Posts
- Add comments in Posts/Wikis/Announcements/FAQ's
- Tag Users and add Emojis
- Users receive notifications if Tagged
- Create Categories for Wikis/Announcements/FAQ's
- Follow Categories and receive notifications when a new item is created in that Category
- Follow Wikis/Announcements/FAQ's and receive notifications if a new comment is added
- Bookmark Wikis/Announcements/FAQ's which will create a "follow up" list
- Organise the Bookmark list
- Upload PDF's to Wikis/Announcements
- Notifications in-app
- Search Posts/Wikis/Announcements/FAQ's
- Users can create a Profile with photo and other details
- Soft delete users
- Pagination
```

```
What was used:
- Simple_form
- Font Awesome
- Devise
- gem 'github-markdown' to tag users
- gem 'gemoji' for emojis
- gem "acts_as_follower" to follow posts
- gem 'bookmark_system' to bookmark posts
- gem 'acts_as_list' to list booksmarked items
- Paperclip - to upload images
- S3 for storage
- Sendgrid for Emails
- Bootstrapt
```

```
Prod -> https://zappi-project.herokuapp.com/
```