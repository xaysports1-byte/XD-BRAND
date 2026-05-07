# XD Brand jersey — ระบบจัดการออเดอร์ผลิตเสื้อ

เว็บแอปสำหรับจัดการออเดอร์ผลิตเสื้อ ลูกค้า งานออกแบบ บัญชีรายรับ-รายจ่าย และออกบิล A4
ทำงานแบบ offline-first (เก็บข้อมูลใน browser ของผู้ใช้)

ติดต่อ: 020 95618276

## 📁 โครงสร้างโฟลเดอร์

```
XD BRAND/
├── index.html       # ไฟล์หลัก (Vercel จะใช้ไฟล์นี้)
├── vercel.json      # การตั้งค่า Vercel
├── package.json     # Metadata ของโปรเจกต์
├── .gitignore       # ไฟล์ที่ git จะไม่ track
├── deploy.sh        # Script deploy คำสั่งเดียว
└── README.md        # เอกสารนี้
```

## 🚀 วิธี Deploy ขึ้น Vercel

### วิธีที่ 1: Drag & Drop (ง่ายที่สุด)

1. ไปที่ [vercel.com](https://vercel.com) แล้ว Sign in
2. คลิก **"Add New..."** → **"Project"**
3. ลากโฟลเดอร์ `XD BRAND` ทั้งโฟลเดอร์ไปวางในหน้า Vercel
4. รอ deploy เสร็จ แล้วได้ URL พร้อมใช้งาน

### วิธีที่ 2: Vercel CLI (แนะนำสำหรับ deploy ซ้ำ)

```bash
# ติดตั้ง Vercel CLI (ทำครั้งเดียว)
npm install -g vercel

# เข้าโฟลเดอร์
cd "~/Documents/XD BRAND"

# Login ครั้งแรก
vercel login

# Deploy
vercel

# Deploy เป็น Production
vercel --prod
```

### วิธีที่ 3: เชื่อมกับ GitHub (deploy อัตโนมัติเมื่อ push)

```bash
# 1. สร้าง repo ใหม่บน github.com (private ก็ได้)

# 2. Init git และ push
cd "~/Documents/XD BRAND"
git init
git add .
git commit -m "Initial commit: XD Brand jersey system"
git branch -M main
git remote add origin https://github.com/USERNAME/xd-brand-jersey.git
git push -u origin main

# 3. ไปที่ vercel.com → Import Git Repository → เลือก repo
# 4. Deploy! ทุกครั้งที่ git push จะ deploy ใหม่อัตโนมัติ
```

## 🧪 ทดสอบในเครื่องก่อน Deploy

```bash
# วิธีที่ 1: เปิดไฟล์ index.html ตรงๆ
open index.html

# วิธีที่ 2: รัน local server
npx serve .
# หรือ
python3 -m http.server 8000
```

## ✨ ฟีเจอร์หลัก

- **หน้าออกแบบ** — ติดตามสถานะ: ยังไม่ได้แบบ / แก้แบบ / แบบผ่าน
- **ออเดอร์ผลิต** — ตาราง 18 คอลัมน์ครบ คำนวณกำไร/ค้างชำระอัตโนมัติ
- **ลูกค้า** — ฐานข้อมูลลูกค้า + ออกบิลรวมต่อลูกค้า
- **บัญชี** — รายรับ-รายจ่าย + ยอดคงเหลือ
- **รายงาน** — กราฟ + Top รูปแบบเสื้อ + Top ลูกค้า
- **ใบบิล A4 แก้ไขได้** — คลิกแก้ได้ทุกจุด, เพิ่ม/ลบรายการ, คำนวณใหม่อัตโนมัติ
- **อัพโหลดโลโก้ + รูปสินค้า** — บีบอัดอัตโนมัติ

## 📝 หมายเหตุสำคัญ

- **ข้อมูลเก็บใน browser ของแต่ละผู้ใช้** (localStorage) ไม่ได้อยู่บน server
- ผู้ใช้แต่ละคนจะมีข้อมูลแยกกัน
- ควรกด **Export** เพื่อ backup ข้อมูลเป็นไฟล์ JSON เป็นประจำ
- ถ้าล้างข้อมูล browser หรือเปลี่ยนเครื่อง ข้อมูลจะหาย ต้อง Import กลับ

## 🔒 ความปลอดภัย

- ไม่มีการส่งข้อมูลออกนอก browser
- ไม่ต้องมี backend หรือฐานข้อมูล
- ไม่มีการเก็บรหัสผ่าน หรือข้อมูลส่วนตัวบน server
- ถ้าต้องการแชร์ข้อมูลระหว่างเครื่อง: ใช้ฟีเจอร์ Export/Import

## 🛠️ การพัฒนาต่อ

ถ้าต้องการเพิ่มฟีเจอร์เช่น:
- เก็บข้อมูลบน cloud (multi-device sync)
- ระบบ login หลายผู้ใช้
- API หรือ webhook
- เชื่อม LINE, Email notification

จะต้องเพิ่ม backend (Vercel Functions, Supabase, Firebase ฯลฯ)
