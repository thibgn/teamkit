# Conventions

- **Services** : `app/services`, héritent de `ApplicationService`, exposent `.call` et répondent par `success(payload:)` ou `failure(error:)`. Pas de `raise` pour une erreur métier attendue.
- **Périmètre** : un contrôleur charge toujours ses données depuis `Current.user.shop`, jamais avec un `find` global.
- **Mailers** : API par paramètres, `Mailer.with(voucher: voucher).method.deliver_later`. Jamais `deliver_now`, jamais d'envoi dans une transaction.
- **Paramètres** : `permit` explicite, jamais `permit!`.
- **Tests** : RSpec + FactoryBot. On ne stubbe pas le mailer : on vérifie `have_enqueued_mail`.
- **Commits** : petits, un sujet par commit.
