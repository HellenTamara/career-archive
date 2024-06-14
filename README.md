# 🎯 Career Archive (under construction)

<img src="https://i.ibb.co/kKs1RR6/career-archive-full.png" alt="career-archive-home" border="0" width="33%"><img src="https://i.postimg.cc/HLXX4kBd/localhost-3000-High-Res-2.png" alt="career-archive-calendar" border="0" width="33%"><img src="https://i.ibb.co/nn0kk5M/localhost-3000-High-Res-3.png" alt="localhost-3000-High-Res-3" border="0" width="33%">

## Introduction

Welcome to Career Archive, a comprehensive web application designed to help you keep track of your accomplishments in your job for future evaluations, job hunting, and salary negotiation. With Career Archive, you can organize and document your professional achievements effectively.

## Features

- **Accomplishment Tracking:** Easily record and organize your accomplishments in your job.
- **Create and Mark Complete on Your Own Goals:** Set your own professional goals and mark them as complete once achieved.
- **Document Upload:** Attach relevant documents or files to each accomplishment entry for reference.
- **Search and Filter:** Quickly search and filter through your accomplishments based on dates.
- **AI Summary** Quickly generate a summary of your achievements for your resume or reports.

## Getting Started
### Setup

Install gems
```
bundle install
```

### ENV Variables
Create `.env` file
```
touch .env
```
Inside `.env`, set these variables. For any APIs, see group Slack channel.
```
CLOUDINARY_URL=your_own_cloudinary_url_key
```

### DB Setup
```
rails db:create
rails db:migrate
rails db:seed
```

### Run a server
```
rails s
```

## Built with

- **Frontend:** HTML, [Bootstrap](https://getbootstrap.com/), JavaScript, Sass
- **Backend:** Ruby on Rails
- **Database:** PostgreSQL
- **Authentication:** [Devise](https://github.com/heartcombo/devise)
- **Form Handling:** [Simple Form](https://github.com/heartcombo/simple_form)
- **File Uploads:** [Cloudinary](https://cloudinary.com/)
- **Calendar:** [Simple Calendar](https://github.com/excid3/simple_calendar)
- **Generative AI:** [Open AI](https://openai.com/index/openai-api)

## Usage

1. Sign up for an account or log in if you already have one.
2. Start adding your accomplishments.
3. Set your own professional goals and mark them as complete once achieved.
4. Upload relevant documents or files for each accomplishment.
5. Utilize search and filter functionalities to easily access specific accomplishments.
6. Keep your accomplishment archive up to date for future evaluations, job hunting, or salary negotiations.
7. Generate summaries for your achievements with a click.

## Future Updates

We're continuously working on improving Career Archive to provide you with more features and a better user experience. Here are some enhancements we plan to implement in future updates:

- **Enhanced Filtering:** Implement advanced filtering options to enable users to search and filter through accomplishments more efficiently.
- **Integration with LinkedIn:** Allow users to import their professional achievements from LinkedIn to streamline data entry.
- **Collaboration Features:** Enable users to share their accomplishment archives with mentors or colleagues for feedback or collaboration.

Stay tuned for these exciting updates!

If you have any feature requests or suggestions for future updates, feel free to share them with us. Your feedback is invaluable in shaping the future of Career Archive.

Rails app generated with the help of [lewagon/rails-templates](https://github.com/lewagon/rails-templates), created by the [Le Wagon coding bootcamp](https://www.lewagon.com) team.
