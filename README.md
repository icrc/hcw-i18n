 # Why this project

Will create Docker images based on [HCW](https://github.com/HCW-home) applications with custom translations, enabling HCW applications to be used in various contexts beyond health.

The main i18n changes are:
- `consultation` replaced by `session`
- `patient` replaced by `service user`

# How to use this project

## Reuse the docker images
Images generated by this GitHub project can be used directly. See  https://github.com/icrc/packages?repo_name=hcw-i18n

## Create custom translated images
To provide custom translations, fork this repository and modify the `<lang>.override.json` files.


# How to add translations
for each project, there is a folder named `assets/i18n` containing `<lang>.override.json` files.
For instance for the patient interface, translations are in the folder [./patient/assets/i18n](./patient/assets/i18n).

# How to start the applications locally

To test translations, all application can be started locally.

By default, the backend is configured to start in development mode, allowing the content of sent emails and SMS to be printed to the backend sysout. To check these messages, please display the backend logs with `docker compose logs -f backend`

## Step 1: Create the file `secrets.env` 
Create the secrets.env file by copying secrets.env.default, then generate and add passwords in the new file.

## Step 2: Start the applications

Run: `docker compose up -d`

## Step 3: Create a user
See https://docs.hcw-at-home.com/users/ for all documentation.

**Main steps:** 
`docker compose exec -ti mongo mongosh`

Then:
`use hcw-athome`

and run this query after having replaced the relevant info:

```
db.user.insertOne({email:"replace-by-your-email",  firstName:"replace-by-your-firstname", lastName:"replace-by-your-lastname", password: "replace-by-a-hashed-password", role: "admin",  createdAt: new Date().getTime(), "updatedAt": new Date().getTime(), "username" : "", phoneNumber: "+41..."})
```


Please have a look to https://docs.hcw-at-home.com/users/ to manually hash the password.


## Step 5: Access to the applications

The local URLs are: 

- Doctor: http://localhost:8081
- Patient: http://localhost:8080
- Admin: http://localhost:8082
display the logs with `docker compose logs -f`