<h1 align="center" style="border-bottom: none">
  <div>
    <a href="https://www.gozne.io">
      <img  alt="gozne" src="https://github.com/gozneco/gozne/assets/5418788/c12cd051-81cd-4402-bc3a-92f2cfdc1b06" width="80" />
      <br>
    </a>
    gozne
  </div>
</h1>
<h3 align="center">
  Open source document filling and signing
</h3>
<p align="center">
  <a href="https://hub.docker.com/r/gozne/gozne">
    <img alt="Docker releases" src="https://img.shields.io/docker/v/gozne/gozne">
  </a>
  <a href="https://discord.gg/qygYCDGck9">
    <img src="https://img.shields.io/discord/1125112641170448454?logo=discord"/>
  </a>
  <a href="https://twitter.com/intent/follow?screen_name=gozneco">
    <img src="https://img.shields.io/twitter/follow/gozneco?style=social" alt="Follow @gozneco" />
  </a>
</p>
<p>
gozne is an open source platform that provides secure and efficient digital document signing and processing. Create PDF forms to have them filled and signed online on any device with an easy-to-use, mobile-optimized web tool.
</p>
<h2 align="center">
  <a href="https://demo.gozne.io">✨ Live Demo</a>
  <span>|</span>
  <a href="//sign_up">☁️ Try in Cloud</a>
</h2>

[![Demo](https://github.com/gozneco/gozne/assets/5418788/d8703ea3-361a-423f-8bfe-eff1bd9dbe14)](https://demo.gozne.io)

## Features

- PDF form fields builder (WYSIWYG)
- 12 field types available (Signature, Date, File, Checkbox etc.)
- Multiple submitters per document
- Automated emails via SMTP
- Files storage on disk or AWS S3, Google Storage, Azure Cloud
- Automatic PDF eSignature
- PDF signature verification
- Users management
- Mobile-optimized
- Signing available in 13 languages
- API and Webhooks for integrations
- Easy to deploy in minutes

## Pro Features

- Company logo and white-label
- User roles
- Automated reminders
- Invitation and identify verification via SMS
- Conditional fields and formulas
- Bulk send with CSV, XLSX spreadsheet import
- SSO / SAML
- Template creation with HTML API ([Guide](https://www.gozne.io/guides/create-pdf-document-fillable-form-with-html-api))
- Template creation with PDF or DOCX and field tags API ([Guide](https://www.gozne.io/guides/use-embedded-text-field-tags-in-the-pdf-to-create-a-fillable-form))
- Embedded signing form ([React](https://github.com/gozneco/gozne-react), [Vue](https://github.com/gozneco/gozne-vue), [Angular](https://github.com/gozneco/gozne-angular) or [JavaScript](https://www.gozne.io/docs/embedded))
- Embedded document form builder ([React](https://github.com/gozneco/gozne-react), [Vue](https://github.com/gozneco/gozne-vue), [Angular](https://github.com/gozneco/gozne-angular) or [JavaScript](https://www.gozne.io/docs/embedded))
- [Learn more](https://www.gozne.io/pricing)

## Deploy

|                                                                                                             Heroku                                                                                                             |                                                                                    Railway                                                                                     |
| :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------: |
|                            [<img alt="Deploy on Heroku" src="https://www.herokucdn.com/deploy/button.svg" height="40">](https://heroku.com/deploy?template=https://github.com/gozneco/gozne-heroku)                            |                   [<img alt="Deploy on Railway" src="https://railway.app/button.svg" height="40">](https://railway.app/template/IGoDnc?referralCode=ruU7JR)                    |
|                                                                                                        **DigitalOcean**                                                                                                        |                                                                                   **Render**                                                                                   |
| [<img alt="Deploy on DigitalOcean" src="https://www.deploytodo.com/do-btn-blue.svg" height="40">](https://cloud.digitalocean.com/apps/new?repo=https://github.com/gozneco/gozne-digitalocean/tree/master&refcode=421d50f53990) | [<img alt="Deploy to Render" src="https://render.com/images/deploy-to-render-button.svg" height="40">](https://render.com/deploy?repo=https://github.com/gozneco/gozne-render) |

#### Docker

```sh
docker run --name gozne -p 3000:3000 -v.:/data gozne/gozne
```

By default gozne docker container uses an SQLite database to store data and configurations. Alternatively, it is possible use PostgreSQL or MySQL databases by specifying the `DATABASE_URL` env variable.

#### Docker Compose

Download docker-compose.yml into your private server:

```sh
curl https://raw.githubusercontent.com/gozneco/gozne/master/docker-compose.yml > docker-compose.yml
```

Run the app under a custom domain over https using docker compose (make sure your DNS points to the server to automatically issue ssl certs with Caddy):

```sh
sudo HOST=your-domain-name.com docker compose up
```

## For Businesses

### Integrate seamless document signing into your web or mobile apps with gozne

At gozne we have expertise and technologies to make documents creation, filling, signing and processing seamlessly integrated with your product. We specialize in working with various industries, including **Banking, Healthcare, Transport, Real Estate, eCommerce, KYC, CRM, and other software products** that require bulk document signing. By leveraging gozne, we can assist in reducing the overall cost of developing and processing electronic documents while ensuring security and compliance with local electronic document laws.

[Book a Meeting](https://www.gozne.io/contact)

## License

Distributed under the AGPLv3 License. See [LICENSE](https://github.com/gozneco/gozne/blob/master/LICENSE) for more information.
Unless otherwise noted, all files © 2023 gozne LLC.

## Tools

- [Signature Maker](https://www.gozne.io/online-signature)
- [Sign Document Online](https://www.gozne.io/sign-documents-online)
- [Fill PDF Online](https://www.gozne.io/fill-pdf)
