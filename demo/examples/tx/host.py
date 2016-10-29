import os

def run():
    print "Audio output example"
    print "===================="
    print
    print "1. Connect Ethernet cable to dev card."
    print "2. Connect speakers to dev card"
    print
    while 1:
        audio_files = [i for i in os.listdir(os.path.dirname(__file__)) if i.endswith(".wav")]
        print "select audio file:"
        while 1:
            for number, path in enumerate(audio_files):
                print number, path
            selection = int(raw_input())
            if selection >= 0 and selection < len(audio_files):
                audio_file = audio_files[selection]
                break
        path = os.path.abspath(os.path.dirname(__file__))
        os.system('sudo python %s/send_audio.py "%s"'%(path, audio_file))

if __name__ == "__main__":
    run()
