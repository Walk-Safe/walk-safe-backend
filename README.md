Hello
<!-- PROJECT SHIELDS -->
[![Build Status](https://travis-ci.com/Walk-Safe/walk-safe-backend.svg?branch=main)](https://travis-ci.com/Walk-Safe/walk-safe-backend)
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
<!-- PROJECT LOGO -->
<br/>

<p align="center">
  <a href="https://github.com/Walk-Safe/walk-safe-backend">
    <img src="">
  </a>
  <h3 align="center">Walk Safe</h3>
  <p align="center">
    Get home safe!
    <br />
    <br />
    <a href="https://github.com/Walk-Safe/walk-safe-backend">Report Bug</a>
    <a href="https://github.com/Walk-Safe/walk-safe-backend">Request Feature</a>
  </p>
</p>

<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
    </li>
    <li>
      <a href="#gettting-started">Contributing</a>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
## About The Project
<!-- [![Product Name Screen Shot][product-screenshot]](https://example.com) -->
Welcome to Walk Safe! This repository contains our backend Rails app. This app makes calls to Google's Distance Matrix API and exposes API endpoints to our [frontend Rails API](https://github.com/Walk-Safe/walk-safe-frontend).
This project is deployed on [Heroku here](heroku-link-here)
### Built With
* [Ruby on Rails](https://rubyonrails.org/)
* [PostgreSQL](https://www.postgresql.org/)
* [RSpec](https://github.com/rspec/rspec-rails)
* [Travis CI](https://travis-ci.com/)
<!--* [OAuth](https://oauth.net/) - * * -->
<!-- CONTRIBUTORS -->

### Contributors
Gaelyn Cooper [GitHub](https://github.com/gaelyn) [LinkedIn](https://www.linkedin.com/in/gaelyn-cooper/)
Joe Mecha [GitHub](https://github.com/joemecha) [LinkedIn](https://www.linkedin.com/in/joemecha/)
Mike Foy [GitHub](https://github.com/foymikek) [LinkedIn](https://www.linkedin.com/in/michael-foy-707ba7b4/)
## Roadmap
The team utilized a [github project board](https://github.com/Walk-Safe/walk-safe-backend) to organize project issues and cooridnate workflow across 6 members, 2 teams and 2 repositories.
See the [open issues](https://github.com/Walk-Safe/walk-safe-backend) for a list of proposed features (and known issues).
<!-- SYSTEM DESIGN -->

### System Design
###### Basic Web Architecture
![Architecture](to make web architecture here)
<!-- CONTRIBUTING -->

## Contributing
Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**. We hope that users provide input to improve their experience and that of others.

### Endpoint

| /graphql |

All endpoints use a `POST` method. 

#### API Contract

All endpoints rely on GraphQL to perform queries and mutations of data.  

1. All queries must be sent in the request body as shown below.
2. The create trip mutation relies on a third party API - [Google's Distance Matrix](https://developers.google.com/maps/documentation/distance-matrix/overview). 

##### GraphQL Queries 
###### Find all users 
```
{
  allUsers {
	firstName
    lastName
    username
    contacts {
      firstName
      lastName
      phoneNumber
    }
  }
}
```
###### Find one user (requires user id)
```
{
  oneUser(id: 1) {
	firstName
    lastName
    username
    contacts {
      firstName
      lastName
      phoneNumber
    }
  }
}
```

##### GraphQL Mutations
###### Create new user (requires: first_name, last_name, username)
```
mutation {
  createUser(input: { firstName: "Claire", lastName: "Littleton", username: "lemonade" }) {
  user {
    id,
    firstName,
    lastName,
    username
  	}
  errors
	}
}
```
###### Create new contact (requires: first_name, last_name, phone_number, user_id)

```
mutation {
  createContact(input: {
	firstName: "Charlie",
    lastName: "Pace",
    phoneNumber: "+12625558333"
    userId: 10
  }) {
  contact {
    id
    firstName
    lastName
    phoneNumber
  	}
  errors
	}
}
```

###### Create new trip (requires: start_point, end_point, travel_mode, user_id)
###### Note: possible travel modes are walking, bicycling, or driving
```
mutation {
  createTrip(input: {startPoint: "Boulder CO", endPoint: "Longmont CO", travelMode: "bicycling", userId: 10}) {
    trip {
      startPoint
      endPoint
      travelMode
      eta
      etaString
      userId
    }
    errors
  }
}
```

##### RESTful route
Text messages are sent utilizing a restful route:
https://walk-safe-backend.herokuapp.com/sms_messages

1. In the request, send the required information by form-data
2. The required fields are __mobile_number__ (beginning with country code (US is '1') followed by the rest of the number -- without punctuation) and __message__

##### New SMS to contact

![New SMS to contact](lib/images/new_sms_screenshot.png)



###### Versions
- Ruby 2.5.3
- Rails 5.2.6
###### Initial Setup
1. Fork the Project
2. Set up the rails database `rails db:{create,migrate}
3. Proper initial setup to be finalized
###### Making a Contribution
1. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
2. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
3. Push to the Branch (`git push origin feature/AmazingFeature`)
4. Open a Pull Request
<!-- LICENSE -->

## License
Distributed under the MIT License. See `LICENSE` for more information.
<!-- CONTACT -->

## Contact
Project Link: [https://github.com/orgs/Walk-Safe](https://github.com/orgs/Walk-Safe)
See the [open issues](https://github.com/Walk-Safe/walk-safe-backend/issues) for a list of proposed features (and known issues).
<!-- ACKNOWLEDGEMENTS -->

## Acknowledgements
* add our ackowledgements for outsourced help if any
<!-- MARKDOWN LINKS & IMAGES -->

<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/Walk-Safe/walk-safe-backend.svg?style=for-the-badge
[contributors-url]: https://github.com/Walk-Safe/walk-safe-backend/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Walk-Safe/walk-safe-backend.svg?style=for-the-badge
[forks-url]: https://github.com/Walk-Safe/walk-safe-backend/network/members
[stars-shield]: https://img.shields.io/github/stars/Walk-Safe/walk-safe-backend.svg?style=for-the-badge
[stars-url]: https://github.com/Walk-Safe/walk-safe-backend/stargazers
[issues-shield]: https://img.shields.io/github/issues/Walk-Safe/walk-safe-backend?style=for-the-badge
[issues-url]: https://github.com/Walk-Safe/walk-safe-backend/issues
<!-- [product-screenshot]: images/screenshot.png -->

[product-screenshot]: images/screenshot.png
