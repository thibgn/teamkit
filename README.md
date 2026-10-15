# Teamkit

Mini-plateforme où des clubs vendent des packs (maillot, short...) à leurs membres, avec des codes à usage unique.

## Prise en main en 5 minutes

```bash
bin/setup          # installe, crée la base, charge les seeds
bin/dev            # http://localhost:3000
bundle exec rspec
```

### Qui fait quoi

| Rôle | Où | Ce qu'il fait |
|---|---|---|
| Responsable de club | http://localhost:3000 (connexion : `manager@as-lyon.test` / `password`) | Voit les packs de son club, le détail d'un pack et ses codes |
| Membre du club | http://localhost:3000/as-lyon/redeem | Saisit un code (ex. `ASLYON-U13-006`) et reçoit le pack à 0 € |

Les emails envoyés par l'application s'affichent sur http://localhost:3000/letter_opener.
Il y a deux clubs dans les données de démonstration (`as-lyon`, `rc-nantes`), avec chacun son responsable : `manager@rc-nantes.test`.

### Vocabulaire

| Mot | Modèle | Sens |
|---|---|---|
| Club | `Shop` | Une association sportive |
| Pack | `Kit` | Un lot d'articles vendu à un prix (« Pack U13 ») |
| Capacité de codes | `VoucherBundle` | Le nombre de codes prévus pour un pack |
| Code | `Voucher` | Un code à usage unique, attribué (ou non) à un membre par son email |
| Commande | `Order` | Créée quand un membre utilise un code (0 €) |

### Où est quoi

```
app/models/        Shop, Kit, VoucherBundle, Voucher, Order...
app/services/      la logique métier (ex. Vouchers::Redeem, hérite d'ApplicationService)
app/controllers/   fins : ils appellent un service et redirigent
app/views/         ERB, pas de JavaScript
spec/              RSpec + FactoryBot
docs/domain.md     les règles métier (à lire)
CONTRIBUTING.md    les conventions de code
```

Pour voir un exemple complet de bout en bout, lis `app/services/vouchers/redeem.rb`, `app/controllers/redemptions_controller.rb` et `spec/services/vouchers/redeem_spec.rb`.
