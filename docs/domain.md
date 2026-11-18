# Domaine

Teamkit permet à un club de vendre des packs (maillot, short...) à ses membres.

- Un **responsable de club** (`User`) gère un seul club (`Shop`).
- Un **pack** (`Kit`) regroupe des articles (`Variant`) à un prix.
- Un pack peut avoir une **capacité de codes** (`VoucherBundle`) : le club distribue des codes (`Voucher`) à ses membres.
- Un membre saisit son code sur `/:slug_du_club/redeem` : il obtient le pack à 0 € (`Order`).

## Règles métier

1. Un code a un seul usage. **Un code utilisé n'est jamais réattribué**, même si aucun email n'y est associé (le club peut remettre un code à la main).
2. **Une commande passée n'est jamais supprimée.** Elle sert de preuve et de base comptable.
3. **Un pack archivé ne reçoit plus de nouvelles attributions** de codes. Ses codes déjà distribués restent valables jusqu'à désactivation.
4. Un responsable ne voit et ne modifie que les packs de son club.
5. La capacité d'un bundle (`expected_quantity`) est un maximum : il ne peut jamais y avoir plus de codes attribués que cette capacité.
6. Les emails de membres sont comparés sans tenir compte de la casse ni des espaces.
7. Un responsable peut **désactiver d'un coup les codes non utilisés d'un pack**. Un code désactivé ne peut plus être utilisé et le membre voit un message dédié. Les codes déjà utilisés et leurs commandes ne changent pas, aucun remboursement ni email n'est déclenché. Les codes créés après une désactivation sont actifs. La désactivation n'archive pas le pack.
