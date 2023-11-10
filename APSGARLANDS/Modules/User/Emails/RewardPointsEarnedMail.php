<?php

namespace Modules\User\Emails;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Contracts\Queue\ShouldQueue;
use Modules\Media\Entities\File;

class RewardPointsEarnedMail extends Mailable
{
    use Queueable, SerializesModels;


    private $firstName;
    public $heading;
    public $text;
    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct($firstName)
    {
        $this->firstName = $firstName;
        $this->heading = trans('user::mail.welcome', ['name' => $firstName]);
        $this->text = trans('user::mail.account_created');
    }
    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->subject(trans('user::mail.welcome', ['name' => $this->firstName]))
            ->view("emails.{$this->getViewName()}", [
                'logo' => File::findOrNew(setting('storefront_mail_logo'))->path,
            ]);
    }

    private function getViewName()
    {
        return 'signupreward' . (is_rtl() ? '_rtl' : '');
    }
}
