

import UIKit

class ViewController: UIViewController {
    
    //Değişkenler
    
    var score = 0
    var timer = Timer()
    var counter = 0
    var turtleArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0

    // Görünümler
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var turtle1: UIImageView!
    @IBOutlet weak var turtle2: UIImageView!
    @IBOutlet weak var turtle3: UIImageView!
    @IBOutlet weak var turtle4: UIImageView!
    @IBOutlet weak var turtle5: UIImageView!
    @IBOutlet weak var turtle6: UIImageView!
    @IBOutlet weak var turtle7: UIImageView!
    @IBOutlet weak var turtle8: UIImageView!
    @IBOutlet weak var turtle9: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ---------- Score u arttırmak ----------
        
        scoreLabel.text = "Score: \(score)"
        
        // Uygulama İlk Çalıştığında High Score u kontrol etme
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore") // highScore u veritabanından alıyoruz (UserDefaults) dan
        
        if storedHighScore == nil { // Eğer storedHighScore boş ise, yani bir veri gelmiyorsa
            highScore = 0 // yüksek score u 0 yaptık
            highScoreLabel.text = "High Score: \(highScore)" // 0 yaptığımız yüksek score u yazdırdık
        }
        
        if let newScore = storedHighScore as? Int{ // Eğer storedHighScore 0 değilse (bir veri yani score varsa) newScore değişkenini oluştur
            highScore = newScore // veri tabanında ki score u yüksek score yaptık
            highScoreLabel.text = "High Score: \(highScore)" // veri tabanında ki yüksek score u yazdırdık
        }
        
        // Kullanıcının kaplumbağaların üzerine tıklayabilmesini sağlıyoruz
        
        turtle1.isUserInteractionEnabled = true
        turtle2.isUserInteractionEnabled = true
        turtle3.isUserInteractionEnabled = true
        turtle4.isUserInteractionEnabled = true
        turtle5.isUserInteractionEnabled = true
        turtle6.isUserInteractionEnabled = true
        turtle7.isUserInteractionEnabled = true
        turtle8.isUserInteractionEnabled = true
        turtle9.isUserInteractionEnabled = true
        
        // recognizer oluşturduk. viewController dan self ettik, action için de '@objc func increaseScore()' fonksiyonunu yazdık
        // ' UITapGestureRecognizer ' kullanıcının hareketlerini algılayıp uygulama içinde yapılması gereken aksiyonu sağlar
        // Yani kullanıcının hangi kaplumbağaya dokunduğunu algılayıp; ' @objc func increaseScore() ' fonksiyonunun çalışmasını istiyoruz
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        // recognizer ları turtle lara atadık
        
        turtle1.addGestureRecognizer(recognizer1)
        turtle2.addGestureRecognizer(recognizer2)
        turtle3.addGestureRecognizer(recognizer3)
        turtle4.addGestureRecognizer(recognizer4)
        turtle5.addGestureRecognizer(recognizer5)
        turtle6.addGestureRecognizer(recognizer6)
        turtle7.addGestureRecognizer(recognizer7)
        turtle8.addGestureRecognizer(recognizer8)
        turtle9.addGestureRecognizer(recognizer9)
        
        // ---------- Kaplumbağaları Hareket Ettirme (imageView ları diziye alıp rastgele görünmesini sağlıyoruz) ----------
        
        turtleArray = [turtle1, turtle2, turtle3, turtle4, turtle5, turtle6, turtle7, turtle8, turtle9] // diziye elemanlarını tanımladık turtleArray.appand(turtle1) bu kullanımla da eleman ekleyebiliriz
        
        
        
        // ---------- Geriye Saydırma (Süre) ----------
        // Timer
        
        counter = 10
        timeLabel.text = "\(counter)" // int olan counter ı string e çevirip label da gösterdik ' String(counter) ' aynı ifade
        
        // timer ın kaç saniye de bir ne yapacağını belirtiyoruz
        // Her bir saniyede viewControoler dan geriye sayması için ' @objc func countDown() ' fonksiyonunu belirtiyoruz, kullanıcıya info vermiyoruz ' nil '
        // Tekrar etmesi için ' true ' yapıyoruz
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        // hideTimer ı başlatıyoruz
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideTurtle), userInfo: nil, repeats: true)
        
        hideTurtle() // Kaplumbağayı sakla adında fonksiyonunu burada çağırdık, çalıştırdık
        
    }
    
    @objc func hideTurtle() { // Kaplumbağayı sakla adında func yazdık
        
        // Bütün kaplumbağaların (imageView) ların sırayla rastgele görünmeznolması için for kullanıyoruz
        
        for turtle in turtleArray { // turtleArray dizisine gidip bütün elemanları tek tek turtle değişkenine atıyor
            turtle.isHidden = true // turtle değişkenindeki bütün elemanları görünmez yapacak
        }
        
        // arc4random_uniform(UInt32(10)) // Bu kullanım 0 - 10 arasında rastgele bir sayı seçmemizi sağlar
        
        let random = Int(arc4random_uniform(UInt32(turtleArray.count - 1))) // turtleArray dizisinin eleman sayısı içerisinden rastgele bir değer seçecek. '-1 yapmamızın sebebi diziler 0 indeksten başladığı için 8. indeks 9. elemanı verecek. -1 yapmazsak program çöker çünkü 9. indekste eleman yok'
        // arc4random_uniform(UInt32(turtleArray.count - 1)) bu değer bize Int döndürmediği için int e çevirdik ve değişkene atadık, bu sayede 0 - 8 arasında rastgele seçilen int rakam elde ettik
        
        turtleArray[random].isHidden = false // turtleArray dizisinin elemanlarından birini görünebilir hale getirecek
        
    }

    // tanımladığımız ' recognizer ' da ki ' action: #selector(increaseScore)) ' kısmı için bu func'u yazdık
    
    @objc func increaseScore() {
        
        score += 1
        scoreLabel.text = "Score: \(score)" // Burda yazdırmamızın amacı score u güncellemek
        
    }
    
    // Timer ın işlem yapacağı fonksiyonu tanımlıyoruz, geriye doğru saymaya yarayacak (countDown)
    
    @objc func countDown() {
        
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 { // Eğer sayaç 0 a gelirse
            timer.invalidate() // Timer ı durduracak
            hideTimer.invalidate() // hideTimer ı durduracak , süre bitince kaplumbağaların görünür olmasnı durduruyoruz
            
            // Oyun bittikten sonra bütün kaplumbağalar görünmez olacak ve üzerine tıklanamayacak
            for turtle in turtleArray { // turtleArray dizisine gidip bütün elemanları tek tek turtle değişkenine atıyor
                turtle.isHidden = true // turtle değişkenindeki bütün elemanları görünmez yapacak
            }
            
            // Yüksek score u kaydetme (Bu küçük bir veri olduğu için 'userDefaults' veri tabanı kullanacağız)
            
            if self.score > self.highScore { // Eğer güncel score hihScore dan daha büyükse
                self.highScore = self.score // highScore artık güncel yapılan score olacak
                self.highScoreLabel.text = "High Score: \(self.highScore)" // Güncellenen en yüksek score u yazdırdık
                // Güncellenen en yüksek score u (High Score) UserDefaults (veritabanı) na kaydediyoruz
                UserDefaults.standard.set(self.highScore, forKey: "highscore") // kaydedilecek değer 'highScore', anahtar kelime "highscore"
            }
            
            // Alert (Kullanıcıya Zamanı Bittiği İçin Uyarı Mesajı Gösterilecek)
            
            let alert = UIAlertController(title: "Süren Bitti !!", message: "Tekrar Oynamak İster misin?", preferredStyle: UIAlertController.Style.alert)
            
            // Uyarı mesajının içerisinde iki buton olacak; Tamam ve Tekrar Oyna
            // Tamam butonunu yapıyoruz
            
            let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.cancel, handler: nil)
            
            // Tekrar oyna butonu
            
            let replayButtun = UIAlertAction(title: "Tekrar Oyna", style: UIAlertAction.Style.default) { UIAlertAction in
                // Tekrar oyna butonuna basıldığında oyunu tekrar başlatacak olan fonksiyonu yazıyoruz
                
                //score u ve counter ı güncellememiz gerekiyor, oyuna yeniden başlanacağı için
                self.score = 0 // self koyarak viewController içindeki score a ulaşıyoruz, hata almamak için self kullandık; score u sıfırladık
                self.scoreLabel.text = "Score: \(self.score)" // Güncellenen score u yazdırdık
                self.counter = 10 // Oyun tekrar başladığı için süremizi 10 saniye yaptık
                self.timeLabel.text = String(self.counter) // Süreyi gösteren label da güncel süreyi gösterdik
                
                //Timer ları çalıştırmamız gerekiyor
                
                // timer ın kaç saniye de bir ne yapacağını belirtiyoruz
                // Her bir saniyede viewControoler dan geriye sayması için ' @objc func countDown() ' fonksiyonunu belirtiyoruz, kullanıcıya info vermiyoruz ' nil '
                // Tekrar etmesi için ' true ' yapıyoruz
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                
                // hideTimer ı başlatıyoruz
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideTurtle), userInfo: nil, repeats: true)
            }
            
            alert.addAction(okButton) // Tamam butonunu ekledik
            alert.addAction(replayButtun) // Tekrar Oyna butonunu ekledik
            self.present(alert, animated: true, completion: nil) // Uyarı mesajını göstermek için bunu yazdık
            
        }
        
    }
    
}

