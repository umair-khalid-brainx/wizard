# Example Rails 7 Project with Wizard Gem

This is an example project built with Ruby on Rails 7, showcasing how the `wizard` gem can be utilized to facilitate step-by-step registration.

## Prerequisites

- Ruby 3.2
- Rails 7.0
- Database supported by Rails

## Installation

1. Clone the repository:

```bash
  git clone https://github.com/your-username/wizard-project.git
  cd wizard-project
```

2. Install dependencies and configure database

```bash
bundle install
yarn
rails db:create db:migrate db:seed
```

## Using the Wizard Gem

This project uses the `wizard` gem to simplify step-by-step registration. Follow the steps below to utilize this functionality:

1. Run the Rails server:

```bash
rails server
```

2. Open your browser and go to http://localhost:3000.

3. Follow the steps in the wizard to complete the step-by-step registration.

## Contributions

Feel free to contribute improvements to this project. Follow the steps below:

1. Fork the repository
2. Create a branch for your changes and commit:

```bash
git checkout -b feature/new-feature
git add .
git commit -m "Add new feature"
```

3. Push changes to your fork:

```bash
git push origin feature/new-feature
```

4. Open a pull request