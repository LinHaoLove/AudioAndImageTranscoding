# AudioAndImageTranscoding
录音转mp3(为了兼容多平台),图片png,jpg相互转码,并压缩(为了兼容多平台,压缩为了省空间)

1, 音频转码

		lame: LAME是目前最好的MP3编码引擎。LAME编码出来的MP3音色纯厚、空间宽
		广、低音清晰、细节表现良好，它独创的心理音响模型技术保证了CD音频还原
		的真实性，配合VBR和ABR参数，音质几乎可以媲美CD音频，但文件体积却非常
		小。对于一个免费引擎，LAME的优势不言而喻。
		
2,使用音频转码时,先导入 lame 库,在导入  头文件 lame.h

		具体使用可以参考代码.
		
3,使用图片转码时,项目 中代码可直接粘贴复制
