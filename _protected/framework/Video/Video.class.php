<?php
/**
 * @title            Video Class
 * @desc             Class is used to create/manipulate videos using FFmpeg.
 *
 * @author           Pierre-Henry Soria <hello@ph7cms.com>
 * @copyright        (c) 2012-2016, Pierre-Henry Soria. All Rights Reserved.
 * @license          GNU General Public License; See PH7.LICENSE.txt and PH7.COPYRIGHT.txt in the root directory.
 * @package          PH7 / Framework / Video
 * @version          0.4
 * @link             http://hizup.com
 */

namespace PH7\Framework\Video;
defined('PH7') or exit('Restricted access');

use
PH7\Framework\Date\Various,
PH7\Framework\Config\Config,
PH7\Framework\File as F;

class Video extends F\Upload
{


    private $oFile, $sType, $sFfmpegPath, $aFile;

    /**
     * @var $aAllowedTypes File formats supported.
     */
    private $aAllowedTypes = [
        'video/mov',
        'video/avi',
        'video/flv',
        'video/mp4',
        'video/mpg',
        'video/mpeg',
        'video/wmv',
        'video/ogg',
        'video/ogv',
        'video/webm',
        'video/mkv'
    ];

    /**
     * @constructor
     * @param array $aFile Example: $_FILES['video']
     * @return void
     * @throws \PH7\Framework\File\Exception If FFmpeg is not installed.
     */
    public function __construct($aFile)
    {
        $this->oFile = new F\File;
        $this->sFfmpegPath = Config::getInstance()->values['video']['handle.ffmpeg_path'];

        if (!file_exists($this->sFfmpegPath))
        {
            $sMsg = t('FFmpeg is not installed on your server or the path cannot be found. Please install and configure the path in "~/YOUR-PROTECTED-FOLDER/app/configs/config.ini"');
            exit($sMsg);
        }

        $this->aFile = $aFile;
        $this->sType = $this->aFile['type'];

        /** Attributes for PH7\Framework\File\Upload abstract class **/
        $this->sMaxSize = Config::getInstance()->values['video']['upload.max_size'];
        $this->iFileSize = (int) $this->aFile['size'];
    }

    /**
     * Video Validate.
     *
     * @return boolean
     * @throws \PH7\Framework\Error\CException\PH7BadMethodCallException If the video file is not found.
     */
    public function validate()
    {
        if (!is_uploaded_file($this->aFile['tmp_name']))
        {
            if (!isDebug())
                return false;
            else
                throw new \PH7\Framework\Error\CException\PH7BadMethodCallException('The file could not be uploaded. Possibly too large.');
        }
        else
        {
            return (in_array($this->sType, $this->aAllowedTypes));
        }
    }

    /**
     * Save Video.
     *
     * @param string $sFile
     * @return boolean
     */
    public function save($sFile)
    {
        return (move_uploaded_file($this->aFile['tmp_name'], $sFile));
    }

    /**
     * Get File Name.
     *
     * @return string
     */
    public function getFileName()
    {
        return $this->aFile['name'];
    }

    /**
     * Convert video file and the extension video type.
     *
     * @param string $sFile.
     * @return string The new name that you entered in the parameter of this method.
     */
    public function rename($sFile)
    {
        $sParams = ''; // By default, we don't use parameter

        $sType = $this->oFile->getFileExt($sFile); // Get the new format
        if ($sType == 'mp4')
            $sParams = '-c copy -copyts';

        exec("$this->sFfmpegPath -i {$this->aFile['tmp_name']} $sParams $sFile");
        return $sFile;
    }

    /*
     * Generate a thumbnail with FFmpeg.
     *
     * @param string $sPicturePath
     * @param integer $iWidth
     * @param integer $iHeight
     * @return string The thumbnail file that you entered in the parameter of this method.
     */
    public function thumbnail($sPicturePath, $iSeconds, $iWidth, $iHeight)
    {
        exec($this->sFfmpegPath . ' -itsoffset -' . $iSeconds . ' -i ' . $this->aFile['tmp_name'] . '  -vcodec mjpeg -vframes 1 -an -f rawvideo -s ' . $iWidth . 'x' . $iHeight . ' ' . $sPicturePath);
        return $sPicturePath;
    }

    /**
     * Gets video duration.
     *
     * @return integer Seconds.
     */
    public function getDuration()
    {
         $sTime = exec($this->sFfmpegPath . ' -i ' . $this->aFile['tmp_name'] . ' 2>&1 | grep "Duration" | cut -d \' \' -f 4 | sed s/,//');
         return Various::timeToSec($sTime);
     }

    /**
     * Get Type Video File.
     *
     * @return string The extension of the video without the dot.
     */
    public function getExt()
    {
        return $this->sType;
    }

    /**
     * Destruction of attributes and temporary file.
     */
    public function __destruct()
    {
        // If it exists, delete the temporary video
        (new F\File)->deleteFile($this->aFile['tmp_name']);

        unset(
            $this->oFile,
            $this->sType,
            $this->sFfmpegPath,
            $this->aFile
        );
    }

}
