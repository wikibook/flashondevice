<?php

	class LogUtils
	{
		public $filename;
		
		public function LogUtils($fileName)
		{
			$this->filename = $fileName;
		}
		
		public function log($content)
		{
			// Let's make sure the file exists and is writable first.
			//if (is_writable($this->filename))
			//{
			//	
				// In our example we're opening $filename in append mode.
				// The file pointer is at the bottom of the file hence
				// that's where $content will go when we fwrite() it.
				if (!$handle = fopen($this->filename, 'a', true))
				{
					//echo "Cannot open file ($this->filename)";
					exit;
				}
				
				$content .= "<br />\n";
				// Write $content to our opened file.
				if (fwrite($handle, $content) === FALSE)
				{
					//echo "Cannot write to file ($this->filename)";
					exit;
				}
				
				//echo "Success, wrote ($content) to file ($this->filename)";
				
				fclose($handle);
				
			//}
			//else
			//{
			//	echo "The file $this->filename is not writable";
			//}
		}
		
		public function getLog()
		{
			$contents = file_get_contents($this->filename);
			return $contents;
		}
		
		public function clearLog()
		{
			if (!$handle = fopen($this->filename, 'w', true))
			{
				exit;
			}
			
			if (fwrite($handle, "") === FALSE)
			{
				exit;
			}
			
			fclose($handle);
		}
	}

?>

