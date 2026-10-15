class VoucherMailer < ApplicationMailer
  def assignment
    @voucher = params[:voucher]
    @kit = @voucher.voucher_bundle.kit
    mail to: @voucher.assigned_to_email, subject: "Votre code pour #{@kit.title}"
  end
end
