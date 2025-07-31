# API Documentation - IBB Management System

## Base URL và Authentication

**Production API Base URL:** `https://api.ibb.vn`
**Development API Base URL:** `http://192.168.1.100:5000` (Raspberry Pi local IP)

**Authentication Method:** Username/Password với session-based auth
**Headers Required:**
```
Content-Type: application/json
```

## User Management Endpoints

### POST /login
Đăng nhập hệ thống

**Request:**
```json
{
  "username": "string",
  "password": "string"
}
```

**Response Success (200):**
```json
{
  "success": true,
  "full_name": "Nguyen Van A",
  "department": "chebien",
  "role": "staff"
}
```

**Response Error (401):**
```json
{
  "success": false,
  "message": "Sai tài khoản hoặc mật khẩu"
}
```

### POST /create_user
Tạo tài khoản mới (Admin only)

**Request:**
```json
{
  "username": "string",
  "password": "string",
  "full_name": "string", 
  "department": "chebien|qa",
  "role": "staff|admin"
}
```

## Production Data Endpoints

### POST /save_form
Lưu dữ liệu form sản xuất

**Request:**
```json
{
  "field_001": "01/01/2024",
  "field_002": "05",
  "field_003": "07", 
  "field_004": "Nguyen Van A",
  "beer_type": "river|hanoi|chaihg",
  "batch_id": 1,
  "created_at": "2024-01-01T10:00:00Z"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Đã lưu dữ liệu vào server",
  "filename": "2024-01-01_me05_tank07_100000.json",
  "location": "active"
}
```

### GET /api/chebien/active/tank/{tank_number}
Lấy danh sách phiếu nấu đang hoạt động cho tank

**Response:**
```json
{
  "success": true,
  "batches": [
    {
      "field_002": "05",
      "field_003": "07",
      "field_025": "15000",
      "beer_type": "river",
      "created_at": "2024-01-01T10:00:00Z",
      "filename": "2024-01-01_me05_tank07_100000.json"
    }
  ],
  "tank_number": 7,
  "count": 1
}
```

### POST /api/chebien/move-to-completed/tank/{tank_number}
Chuyển phiếu từ active sang completed

**Request:**
```json
{
  "tank_number": 7,
  "total_filtered": 14500,
  "filter_date": "2024-01-15",
  "operator": "QA_User"
}
```

## QA Data Endpoints

### GET /api/qa/filtered-volume/tank/{tank_number}
Lấy tổng lượng đã lọc cho tank

**Response:**
```json
{
  "success": true,
  "totalFiltered": 14500,
  "tank_number": 7,
  "filter_files": [
    {
      "filename": "loc_tank7_day_2024-01-15.json",
      "date": "2024-01-15",
      "volume_filtered": 14500,
      "lo_count": 5
    }
  ]
}
```

### GET /api/qa/tank-metrics/tank/{tank_number}
Lấy metrics hiện tại của tank

**Response:**
```json
{
  "success": true,
  "temperature": 12.5,
  "pressure": 1.2,
  "tank_number": 7,
  "last_updated": "2024-01-15T14:30:00Z",
  "source": "lenmen_log"
}
```

### POST /api/qa/lenmen/save
Lưu nhật ký lên men

**Request:**
```json
{
  "tank_number": 7,
  "log_data": {
    "tank_so": 7,
    "ngay": "2024-01-01",
    "me_so": "05",
    "plato_tb": 12.5,
    "tong_the_tich": 15000,
    "data": [
      {
        "ngay_thu": 1,
        "gio": "08:00",
        "plato": 12.5,
        "pH": 4.2,
        "te_bao": 10,
        "nhiet_do": 12.0,
        "ap_suat": 1.0
      }
    ]
  }
}
```

## Image Upload Endpoints

### POST /api/upload-image
Upload ảnh từ mobile app

**Request:** `multipart/form-data`
- `image`: File (JPEG/PNG)
- `folder`: "Chebien/Plato|Chebien/Hanoi|Chebien/ChaiHG"
- `fieldId`: "field_100_photo"
- `batchId`: "string"
- `tankNumber`: "string"
- `batchNumber`: "string"
- `beerType`: "river|hanoi|chaihg"

**Response:**
```json
{
  "success": true,
  "imageUrl": "/uploads/Chebien/Plato/River_Tank07_Batch05_field_100_photo_20240101-100000.jpg",
  "fileName": "River_Tank07_Batch05_field_100_photo_20240101-100000.jpg",
  "fileSize": 2048576
}
```

### GET /uploads/{path}
Serve uploaded images

**Example:** `/uploads/Chebien/Plato/River_Tank07_Batch05_field_100_photo_20240101-100000.jpg`

## System Management Endpoints

### GET /health
Health check endpoint

**Response:**
```json
{
  "status": "healthy",
  "timestamp": "2024-01-01T10:00:00Z",
  "version": "2.0.0",
  "directories": {
    "chebien_active": true,
    "chebien_completed": true,
    "qa": true,
    "uploads": true
  },
  "stats": {
    "user_count": 5,
    "active_batches": 12,
    "completed_batches": 145,
    "image_count": 89
  }
}
```

### GET /api/stats/overview
Thống kê tổng quan hệ thống

**Response:**
```json
{
  "success": true,
  "stats": {
    "chebien": {
      "active": 12,
      "completed": 145,
      "by_beer_type": {
        "river": 89,
        "hanoi": 45,
        "chaihg": 23
      }
    },
    "qa": {
      "lenmen_logs": 78,
      "filter_logs": 67
    },
    "images": {
      "total": 234,
      "total_size_mb": 156.7
    }
  }
}
```

## Error Handling

### Error Response Format
```json
{
  "success": false,
  "error": "Error message in Vietnamese",
  "details": "Technical details for debugging",
  "code": "ERROR_CODE",
  "timestamp": "2024-01-01T10:00:00Z"
}
```

### Common Error Codes
- `AUTH_FAILED` - Authentication failure
- `PERMISSION_DENIED` - Insufficient permissions
- `VALIDATION_ERROR` - Data validation failure
- `FILE_NOT_FOUND` - Requested resource not found
- `NETWORK_ERROR` - Connection issues
- `SERVER_ERROR` - Internal server error

## Rate Limiting

- **Standard APIs:** 100 requests/minute per user
- **Image Upload:** 10 uploads/minute per user  
- **Authentication:** 5 attempts/minute per IP

## File Naming Conventions

### Production Batch Files
**Format:** `YYYY-MM-DD_meXX_tankYY_HHMMSS.json`
**Example:** `2024-01-01_me05_tank07_100000.json`

### QA Log Files
**Fermentation:** `tank_{X}_day_{YYYY-MM-DD}.json`
**Filter:** `loc_tank{X}_day_{YYYY-MM-DD}.json`

### Image Files  
**Format:** `{BeerType}_Tank{X}_Batch{Y}_{field_id}_{timestamp}.jpg`
**Example:** `River_Tank07_Batch05_field_100_photo_20240101-100000.jpg`

## Data Validation Rules

### Required Fields (All Beer Types)
- `field_001`: Date in DD/MM/YYYY format
- `field_002`: Batch number (string)
- `field_003`: Tank number (1-17)
- `field_004`: Employee name (non-empty string)

### Beer Type Specific
- **River:** 109 fields total, auto-calculations enabled
- **Hanoi:** Specialized fields for traditional brewing
- **ChaiHG:** Premium quality control fields

### QA Data Validation
- **Temperature:** -5°C to 50°C
- **Pressure:** 0 to 5 Bar
- **Plato:** 0 to 25 degrees
- **pH:** 2.0 to 8.0
- **Volume:** > 0 liters

---

*API Documentation được cập nhật định kỳ. Mọi thay đổi về endpoints hoặc data structures cần được document tại đây.*
