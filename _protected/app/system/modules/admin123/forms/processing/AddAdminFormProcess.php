<?php
/**
 * @author         Pierre-Henry Soria <ph7software@gmail.com>
 * @copyright      (c) 2012-2016, Pierre-Henry Soria. All Rights Reserved.
 * @license        GNU General Public License; See PH7.LICENSE.txt and PH7.COPYRIGHT.txt in the root directory.
 * @package        PH7 / App / System / Module / Admin / From / Processing
 */
namespace PH7;
defined('PH7') or exit('Restricted access');

use
PH7\Framework\Util\Various,
PH7\Framework\Ip\Ip,
PH7\Framework\Mvc\Router\Uri,
PH7\Framework\Url\Header;

class AddAdminFormProcess extends Form
{

    public function __construct()
    {
        parent::__construct();

        $aData = [
            'email' => $this->httpRequest->post('mail'),
            'username' => $this->httpRequest->post('username'),
            'password' => $this->httpRequest->post('password'),
            'first_name' => $this->httpRequest->post('first_name'),
            'last_name' => $this->httpRequest->post('last_name'),
            'sex' => $this->httpRequest->post('sex'),
            'time_zone' => $this->httpRequest->post('time_zone'),
            'ip' => Ip::get()
        ];

        (new AdminModel)->add($aData);

        Header::redirect(Uri::get(PH7_ADMIN_MOD, 'admin', 'browse'), t('The administrator has been successfully added.'));
    }

}
