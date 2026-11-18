module VouchersHelper
  def voucher_state(voucher)
    if voucher.redeemed? then "Utilisé"
    elsif voucher.deactivated? then "Désactivé"
    else "Disponible"
    end
  end

  def voucher_deactivation_confirmation(count)
    question = if count > 1
      "Désactiver les #{count} codes non utilisés de ce pack ? Plus personne ne pourra les utiliser."
    else
      "Désactiver le code non utilisé de ce pack ? Plus personne ne pourra l'utiliser."
    end
    "#{question} Les commandes déjà passées sont conservées. Cette action est irréversible."
  end
end
