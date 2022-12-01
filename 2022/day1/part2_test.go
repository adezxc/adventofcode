package day1

import "testing"

func TestThreeMaxCalories(t *testing.T) {
	type args struct {
		filename string
	}
	tests := []struct {
		name    string
		args    args
		want    int
		wantErr bool
	}{
		{"empty", args{}, 0, true},
		{"example", args{filename: "test_input.txt"}, 45000, false},
		{"input", args{filename: "input.txt"}, 203420, false},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			got, err := ThreeMaxCalories(tt.args.filename)
			if (err != nil) != tt.wantErr {
				t.Errorf("ThreeMaxCalories() error = %v, wantErr %v", err, tt.wantErr)
				return
			}
			if got != tt.want {
				t.Errorf("ThreeMaxCalories() = %v, want %v", got, tt.want)
			}
		})
	}
}
