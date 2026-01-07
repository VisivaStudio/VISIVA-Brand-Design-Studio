//___FILEHEADER___

import React, { useState, useRef } from 'react';
import { Palette, Type, Check, ArrowRight, Save, Upload, X, FileText, Mail } from 'lucide-react';

const VisivaApp = () => {
  const [step, setStep] = useState(1);
  const [showUploadModal, setShowUploadModal] = useState(false);
  const [showContactModal, setShowContactModal] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const fileInputRef = useRef(null);
  
  const [brandData, setBrandData] = useState({
    businessName: '',
    tagline: '',
    industry: '',
    vibe: [],
    primaryColor: '#FF6B9D',
    secondaryColor: '#A78BFA',
    accentColor: '#60A5FA',
    neutralColor: '#E5E7EB',
    darkColor: '#1F2937',
    lightColor: '#F9FAFB',
    fontPrimary: 'Inter',
    fontSecondary: 'Playfair Display',
    brandVoice: [],
    uploadedFiles: [],
    contactName: '',
    contactEmail: '',
    contactPhone: '',
    contactCompany: '',
    projectTimeline: '',
    additionalNotes: ''
  });

  const industries = ['Creative Agency', 'Tech Startup', 'E-commerce', 'Food & Beverage', 'Wellness', 'Consulting', 'Other'];
  const vibes = ['Bold & Energetic', 'Elegant & Sophisticated', 'Playful & Creative', 'Modern & Minimal', 'Warm & Welcoming', 'Tech & Innovative'];
  const brandVoices = ['Professional', 'Friendly', 'Inspirational', 'Witty', 'Educational', 'Luxury'];
  
  const fontPairs = [
    { primary: 'Inter', secondary: 'Playfair Display', style: 'Modern & Classic', category: 'Versatile' },
    { primary: 'Poppins', secondary: 'Merriweather', style: 'Friendly & Professional', category: 'Versatile' },
    { primary: 'Montserrat', secondary: 'Lora', style: 'Bold & Elegant', category: 'Sophisticated' },
    { primary: 'Raleway', secondary: 'Open Sans', style: 'Clean & Versatile', category: 'Minimal' },
    { primary: 'Bebas Neue', secondary: 'Roboto', style: 'Impactful', category: 'Bold' },
    { primary: 'Space Grotesk', secondary: 'IBM Plex Sans', style: 'Tech & Modern', category: 'Tech' }
  ];

  const handleFileUpload = (event) => {
    const files = Array.from(event.target.files);
    const newFiles = files.map(file => ({
      id: Date.now() + Math.random(),
      name: file.name,
      size: file.size,
      type: file.type,
      preview: file.type.startsWith('image/') ? URL.createObjectURL(file) : null
    }));
    setBrandData(prev => ({ ...prev, uploadedFiles: [...prev.uploadedFiles, ...newFiles] }));
  };

  const removeFile = (fileId) => {
    setBrandData(prev => ({ ...prev, uploadedFiles: prev.uploadedFiles.filter(f => f.id !== fileId) }));
  };

  const toggleVibe = (vibe) => {
    setBrandData(prev => ({
      ...prev,
      vibe: prev.vibe.includes(vibe) ? prev.vibe.filter(v => v !== vibe) : [...prev.vibe, vibe]
    }));
  };

  const toggleVoice = (voice) => {
    setBrandData(prev => ({
      ...prev,
      brandVoice: prev.brandVoice.includes(voice) ? prev.brandVoice.filter(v => v !== voice) : [...prev.brandVoice, voice]
    }));
  };

  const sendToEmail = async () => {
    setIsSubmitting(true);
    console.log('Sending to info@visiva.co.za:', brandData);
    await new Promise(resolve => setTimeout(resolve, 1500));
    setIsSubmitting(false);
    setShowContactModal(false);
    setStep(6);
  };

  const canProceed = () => {
    if (step === 1) return brandData.businessName && brandData.industry;
    if (step === 2) return brandData.vibe.length > 0;
    if (step === 5) return brandData.brandVoice.length > 0;
    return true;
  };

  const getStepTitle = () => {
    const titles = {
      1: 'Business Information',
      2: 'Brand Personality',
      3: 'Color Palette',
      4: 'Typography',
      5: 'Brand Voice',
      6: 'Confirmation'
    };
    return titles[step] || '';
  };

  const getBackgroundGradient = () => {
    const gradients = {
      1: 'from-gray-900 via-gray-800 to-gray-900',
      2: 'from-slate-900 via-slate-800 to-slate-900',
      3: 'from-zinc-900 via-zinc-800 to-zinc-900',
      4: 'from-neutral-900 via-neutral-800 to-neutral-900',
      5: 'from-stone-900 via-stone-800 to-stone-900',
      6: 'from-gray-800 via-gray-700 to-gray-800'
    };
    return gradients[step] || gradients[1];
  };

  const buttonStyleSelected = 'bg-gradient-to-br from-pink-400 via-pink-500 to-pink-600 shadow-[0_8px_16px_rgba(236,72,153,0.3),inset_0_-2px_8px_rgba(0,0,0,0.3),inset_0_2px_8px_rgba(255,255,255,0.2)] scale-95';
  const buttonStyleUnselected = 'bg-gradient-to-br from-gray-700 to-gray-800 shadow-[0_4px_12px_rgba(0,0,0,0.5),inset_0_-2px_4px_rgba(0,0,0,0.4),inset_0_2px_4px_rgba(255,255,255,0.1)] hover:shadow-[0_6px_16px_rgba(0,0,0,0.6)] hover:-translate-y-0.5';

  return (
    <div className={`min-h-screen bg-gradient-to-br ${getBackgroundGradient()} text-white transition-all duration-700`}>
      <div className="border-b border-white/10 bg-black/20 backdrop-blur-sm shadow-2xl sticky top-0 z-50">
        <div className="max-w-6xl mx-auto px-4 sm:px-8 py-4 sm:py-6">
          <div className="flex items-center justify-between">
            <div className="text-2xl sm:text-3xl font-bold bg-gradient-to-r from-pink-400 via-blue-400 to-cyan-400 bg-clip-text text-transparent">
              VISIVA™
            </div>
            <div className="flex gap-2">
              <button
                onClick={() => setShowUploadModal(true)}
                className="px-3 py-2 sm:px-4 sm:py-2 bg-gradient-to-br from-pink-400 via-pink-500 to-pink-600 hover:from-pink-500 hover:via-pink-600 hover:to-pink-700 rounded-lg text-sm font-semibold flex items-center gap-2 shadow-lg hover:-translate-y-0.5 transition-all transform"
              >
                <Upload className="w-4 h-4" />
                <span className="hidden sm:inline">Upload</span>
              </button>
              <button
                onClick={() => alert('Saved!')}
                className="px-3 py-2 bg-gradient-to-br from-gray-600 to-gray-700 hover:from-gray-500 hover:to-gray-600 rounded-lg text-sm flex items-center gap-2 shadow-lg hover:-translate-y-0.5 transition-all transform"
              >
                <Save className="w-4 h-4" />
                <span className="hidden sm:inline">Save</span>
              </button>
            </div>
          </div>
          <div className="mt-3 text-center text-sm text-gray-400">
            Step {step} of 5: {getStepTitle()}
            {brandData.uploadedFiles.length > 0 && (
              <span className="ml-4 text-blue-400">• {brandData.uploadedFiles.length} file(s) uploaded</span>
            )}
          </div>
        </div>
      </div>

      <div className="max-w-6xl mx-auto px-4 py-8">
        <div className="flex justify-center gap-4 mb-8">
          {[1, 2, 3, 4, 5].map(num => (
            <div key={num} className={`w-10 h-10 rounded-full flex items-center justify-center ${step >= num ? 'bg-gradient-to-r from-pink-500 to-blue-500' : 'bg-white/10'}`}>
              {step > num ? <Check className="w-5 h-5" /> : num}
            </div>
          ))}
        </div>

        {step === 1 && (
          <div className="max-w-2xl mx-auto space-y-6">
            <h2 className="text-3xl font-bold text-center mb-6">Business Information</h2>
            <div className="bg-white/5 rounded-2xl p-6 border border-white/10 space-y-4">
              <div>
                <label className="block text-sm font-semibold mb-2">Business Name *</label>
                <input
                  type="text"
                  value={brandData.businessName}
                  onChange={(e) => setBrandData({...brandData, businessName: e.target.value})}
                  className="w-full px-4 py-3 bg-white/10 border border-white/20 rounded-lg focus:outline-none text-white"
                />
              </div>
              <div>
                <label className="block text-sm font-semibold mb-2">Tagline (Optional)</label>
                <input
                  type="text"
                  value={brandData.tagline}
                  onChange={(e) => setBrandData({...brandData, tagline: e.target.value})}
                  className="w-full px-4 py-3 bg-white/10 border border-white/20 rounded-lg focus:outline-none text-white"
                />
              </div>
              <div>
                <label className="block text-sm font-semibold mb-2">Industry *</label>
                <div className="grid grid-cols-2 gap-2">
                  {industries.map(ind => (
                    <button
                      key={ind}
                      onClick={() => setBrandData({...brandData, industry: ind})}
                      className={`px-4 py-3 rounded-lg font-semibold transition-all transform ${
                        brandData.industry === ind ? buttonStyleSelected : buttonStyleUnselected
                      }`}
                    >
                      {ind}
                    </button>
                  ))}
                </div>
              </div>
            </div>
          </div>
        )}

        {step === 2 && (
          <div className="max-w-4xl mx-auto">
            <h2 className="text-3xl font-bold text-center mb-6">Brand Personality</h2>
            <p className="text-center text-gray-400 mb-6">Select characteristics that define your brand</p>
            <div className="grid grid-cols-2 lg:grid-cols-3 gap-4">
              {vibes.map(vibe => (
                <button
                  key={vibe}
                  onClick={() => toggleVibe(vibe)}
                  className={`p-6 rounded-2xl font-semibold transition-all transform ${
                    brandData.vibe.includes(vibe) ? buttonStyleSelected : buttonStyleUnselected
                  }`}
                >
                  <div className="font-bold">{vibe}</div>
                  {brandData.vibe.includes(vibe) && <Check className="w-5 h-5 mx-auto mt-2" />}
                </button>
              ))}
            </div>
          </div>
        )}

        {step === 3 && (
          <div className="max-w-3xl mx-auto">
            <h2 className="text-3xl font-bold text-center mb-6">Color Palette</h2>
            <p className="text-center text-gray-400 mb-6">Create your comprehensive color system</p>
            <div className="bg-white/5 rounded-2xl p-6 border border-white/10 space-y-6">
              <div className="grid md:grid-cols-2 gap-4">
                {[
                  { label: 'Primary Color', key: 'primaryColor', desc: 'Main brand color' },
                  { label: 'Secondary Color', key: 'secondaryColor', desc: 'Supporting color' },
                  { label: 'Accent Color', key: 'accentColor', desc: 'Call-to-action highlights' },
                  { label: 'Neutral Color', key: 'neutralColor', desc: 'Backgrounds and borders' },
                  { label: 'Dark Color', key: 'darkColor', desc: 'Text and headers' },
                  { label: 'Light Color', key: 'lightColor', desc: 'Light backgrounds' }
                ].map(({ label, key, desc }) => (
                  <div key={key} className="bg-gradient-to-br from-gray-700 to-gray-800 rounded-lg p-4 shadow-lg">
                    <label className="block text-sm font-semibold mb-1">{label}</label>
                    <p className="text-xs text-gray-400 mb-2">{desc}</p>
                    <div className="flex gap-2">
                      <input
                        type="color"
                        value={brandData[key]}
                        onChange={(e) => setBrandData({...brandData, [key]: e.target.value})}
                        className="w-16 h-16 rounded-lg cursor-pointer"
                      />
                      <input
                        type="text"
                        value={brandData[key]}
                        onChange={(e) => setBrandData({...brandData, [key]: e.target.value})}
                        className="flex-1 px-3 py-2 bg-gray-800 border border-gray-600 rounded-lg focus:outline-none text-white"
                      />
                    </div>
                  </div>
                ))}
              </div>

              <div className="pt-6 border-t border-white/20">
                <h4 className="text-sm font-semibold mb-4">Color Palette Preview</h4>
                
                <div className="grid grid-cols-6 gap-2 mb-4">
                  {[
                    { key: 'primaryColor', label: 'Primary' },
                    { key: 'secondaryColor', label: 'Secondary' },
                    { key: 'accentColor', label: 'Accent' },
                    { key: 'neutralColor', label: 'Neutral' },
                    { key: 'darkColor', label: 'Dark' },
                    { key: 'lightColor', label: 'Light' }
                  ].map(({ key, label }) => (
                    <div key={key} className="text-center">
                      <div
                        className="w-full aspect-square rounded-lg shadow-lg border border-white/10 mb-1"
                        style={{backgroundColor: brandData[key]}}
                      />
                      <p className="text-xs text-gray-400 truncate">{label}</p>
                    </div>
                  ))}
                </div>

                <div className="bg-white/5 rounded-xl p-4 border border-white/10">
                  <p className="text-xs text-gray-400 mb-2">Gradient Preview</p>
                  <div
                    className="h-24 rounded-lg shadow-2xl"
                    style={{
                      background: `linear-gradient(135deg, ${brandData.primaryColor}, ${brandData.secondaryColor}, ${brandData.accentColor})`
                    }}
                  />
                </div>
              </div>
            </div>
          </div>
        )}

        {step === 4 && (
          <div className="max-w-5xl mx-auto space-y-6">
            <h2 className="text-3xl font-bold text-center mb-6">Typography Selection</h2>
            <p className="text-center text-gray-400 mb-6">Choose your font pairing</p>
            <div className="bg-white/5 rounded-2xl p-6 border border-white/10">
              <div className="grid md:grid-cols-2 gap-3">
                {fontPairs.map(pair => (
                  <button
                    key={pair.primary}
                    onClick={() => setBrandData({...brandData, fontPrimary: pair.primary, fontSecondary: pair.secondary})}
                    className={`p-4 rounded-xl text-left transition-all transform ${
                      brandData.fontPrimary === pair.primary
                        ? 'bg-gradient-to-br from-blue-400 via-blue-500 to-blue-600 shadow-lg scale-95'
                        : buttonStyleUnselected
                    }`}
                  >
                    <div className="font-bold text-sm">{pair.primary} + {pair.secondary}</div>
                    <div className="text-xs opacity-80">{pair.style}</div>
                    <div className="text-xs px-2 py-1 bg-white/10 rounded inline-block mt-2">{pair.category}</div>
                  </button>
                ))}
              </div>
            </div>
          </div>
        )}

        {step === 5 && (
          <div className="max-w-4xl mx-auto">
            <h2 className="text-3xl font-bold text-center mb-6">Brand Voice</h2>
            <p className="text-center text-gray-400 mb-6">Select one or two communication styles</p>
            <div className="grid grid-cols-2 lg:grid-cols-3 gap-4">
              {brandVoices.map(voice => (
                <button
                  key={voice}
                  onClick={() => toggleVoice(voice)}
                  className={`p-6 rounded-2xl font-semibold transition-all transform ${
                    brandData.brandVoice.includes(voice) ? buttonStyleSelected : buttonStyleUnselected
                  }`}
                >
                  <div className="font-bold">{voice}</div>
                  {brandData.brandVoice.includes(voice) && <Check className="w-5 h-5 mx-auto mt-2" />}
                </button>
              ))}
            </div>
            <div className="mt-8 text-center">
              <button
                onClick={() => setShowContactModal(true)}
                disabled={brandData.brandVoice.length === 0}
                className="px-8 py-4 bg-gradient-to-br from-pink-400 via-pink-500 to-pink-600 rounded-xl font-bold text-lg disabled:opacity-50 disabled:cursor-not-allowed inline-flex items-center gap-2 shadow-lg hover:-translate-y-1 transition-all transform"
              >
                <Mail className="w-5 h-5" />
                Submit Brand Kit Request
                <ArrowRight className="w-5 h-5" />
              </button>
              {brandData.brandVoice.length === 0 && (
                <p className="text-sm text-gray-400 mt-4">Please select at least one brand voice to continue</p>
              )}
            </div>
          </div>
        )}

        {step === 6 && (
          <div className="max-w-4xl mx-auto text-center">
            <h2 className="text-3xl font-bold mb-4">Request Submitted Successfully</h2>
            <p className="text-gray-400 mb-2">{brandData.businessName}</p>
            <p className="text-sm text-gray-500 mb-8">The Visiva team will contact you at {brandData.contactEmail}</p>
            <div className="grid md:grid-cols-2 gap-6 mt-8">
              <div className="bg-white/5 rounded-2xl p-6 border border-white/10">
                <h3 className="font-bold mb-4 flex items-center gap-2">
                  <Palette className="w-5 h-5" /> Color System
                </h3>
                <div className="grid grid-cols-3 gap-2">
                  {['primaryColor', 'secondaryColor', 'accentColor', 'neutralColor', 'darkColor', 'lightColor'].map(key => (
                    <div key={key} className="h-16 rounded-lg" style={{backgroundColor: brandData[key]}} />
                  ))}
                </div>
              </div>
              <div className="bg-white/5 rounded-2xl p-6 border border-white/10">
                <h3 className="font-bold mb-4 flex items-center gap-2">
                  <Type className="w-5 h-5" /> Typography
                </h3>
                <p className="text-left">Primary: {brandData.fontPrimary}</p>
                <p className="text-left">Secondary: {brandData.fontSecondary}</p>
              </div>
            </div>
          </div>
        )}

        {showContactModal && (
          <div className="fixed inset-0 bg-black/70 flex items-center justify-center z-50 p-4">
            <div className="bg-gray-900 rounded-2xl p-6 max-w-2xl w-full border border-white/20 max-h-[90vh] overflow-y-auto">
              <div className="flex justify-between items-center mb-6">
                <h3 className="text-xl font-bold">Contact Information</h3>
                <button onClick={() => setShowContactModal(false)} className="p-2 bg-white/10 rounded-lg hover:bg-white/20">
                  <X className="w-5 h-5" />
                </button>
              </div>
              <p className="text-gray-400 text-sm mb-6">Provide your details so the Visiva team can contact you</p>
              <div className="space-y-4">
                <input
                  type="text"
                  placeholder="Full Name *"
                  value={brandData.contactName}
                  onChange={(e) => setBrandData({...brandData, contactName: e.target.value})}
                  className="w-full px-4 py-3 bg-white/10 border border-white/20 rounded-lg focus:outline-none text-white"
                />
                <input
                  type="email"
                  placeholder="Email Address *"
                  value={brandData.contactEmail}
                  onChange={(e) => setBrandData({...brandData, contactEmail: e.target.value})}
                  className="w-full px-4 py-3 bg-white/10 border border-white/20 rounded-lg focus:outline-none text-white"
                />
                <input
                  type="tel"
                  placeholder="Phone Number (Optional)"
                  value={brandData.contactPhone}
                  onChange={(e) => setBrandData({...brandData, contactPhone: e.target.value})}
                  className="w-full px-4 py-3 bg-white/10 border border-white/20 rounded-lg focus:outline-none text-white"
                />
                <input
                  type="text"
                  placeholder="Company Name (Optional)"
                  value={brandData.contactCompany}
                  onChange={(e) => setBrandData({...brandData, contactCompany: e.target.value})}
                  className="w-full px-4 py-3 bg-white/10 border border-white/20 rounded-lg focus:outline-none text-white"
                />
                <select
                  value={brandData.projectTimeline}
                  onChange={(e) => setBrandData({...brandData, projectTimeline: e.target.value})}
                  className="w-full px-4 py-3 bg-white/10 border border-white/20 rounded-lg focus:outline-none text-white"
                >
                  <option value="">Project Timeline (Optional)</option>
                  <option value="urgent">Urgent (1-2 weeks)</option>
                  <option value="soon">Soon (3-4 weeks)</option>
                  <option value="flexible">Flexible (1-2 months)</option>
                  <option value="planning">Just Planning</option>
                </select>
                <textarea
                  placeholder="Additional Notes (Optional)"
                  value={brandData.additionalNotes}
                  onChange={(e) => setBrandData({...brandData, additionalNotes: e.target.value})}
                  rows={4}
                  className="w-full px-4 py-3 bg-white/10 border border-white/20 rounded-lg focus:outline-none resize-none text-white"
                />
              </div>
              <div className="mt-6 flex gap-3">
                <button
                  onClick={() => setShowContactModal(false)}
                  className="flex-1 px-6 py-3 bg-white/10 hover:bg-white/20 rounded-lg font-semibold transition-all"
                >
                  Cancel
                </button>
                <button
                  onClick={sendToEmail}
                  disabled={!brandData.contactName || !brandData.contactEmail || isSubmitting}
                  className="flex-1 px-6 py-3 bg-gradient-to-br from-pink-400 via-pink-500 to-pink-600 hover:from-pink-500 hover:via-pink-600 hover:to-pink-700 rounded-lg font-semibold disabled:opacity-50 disabled:cursor-not-allowed shadow-lg transition-all"
                >
                  {isSubmitting ? 'Submitting...' : 'Submit Request'}
                </button>
              </div>
            </div>
          </div>
        )}

        {showUploadModal && (
          <div className="fixed inset-0 bg-black/70 flex items-center justify-center z-50 p-4">
            <div className="bg-gray-900 rounded-2xl p-6 max-w-2xl w-full border border-white/20 max-h-[90vh] overflow-y-auto">
              <div className="flex justify-between items-center mb-6">
                <h3 className="text-xl font-bold">Upload Brand Assets</h3>
                <button onClick={() => setShowUploadModal(false)} className="p-2 bg-white/10 rounded-lg hover:bg-white/20">
                  <X className="w-5 h-5" />
                </button>
              </div>
              <p className="text-gray-400 text-sm mb-6">Upload existing logos, brand guidelines, or inspiration images</p>
              
              <input
                ref={fileInputRef}
                type="file"
                multiple
                accept="image/*,.pdf,.doc,.docx"
                onChange={handleFileUpload}
                className="hidden"
              />
              
              <button
                onClick={() => fileInputRef.current?.click()}
                className="w-full py-12 border-2 border-dashed border-white/20 rounded-xl hover:border-pink-400/50 hover:bg-white/5 transition-all flex flex-col items-center gap-3"
              >
                <Upload className="w-12 h-12 text-gray-400" />
                <div className="text-center">
                  <p className="font-semibold">Click to upload files</p>
                  <p className="text-sm text-gray-400">or drag and drop</p>
                </div>
              </button>

              {brandData.uploadedFiles.length > 0 && (
                <div className="mt-6 space-y-2">
                  <h4 className="font-semibold text-sm">Uploaded Files ({brandData.uploadedFiles.length})</h4>
                  {brandData.uploadedFiles.map(file => (
                    <div key={file.id} className="flex items-center gap-3 p-3 bg-white/5 rounded-lg border border-white/10">
                      {file.preview ? (
                        <img src={file.preview} alt={file.name} className="w-12 h-12 object-cover rounded" />
                      ) : (
                        <div className="w-12 h-12 bg-white/10 rounded flex items-center justify-center">
                          <FileText className="w-6 h-6" />
                        </div>
                      )}
                      <div className="flex-1 min-w-0">
                        <p className="font-semibold text-sm truncate">{file.name}</p>
                        <p className="text-xs text-gray-400">{(file.size / 1024).toFixed(1)} KB</p>
                      </div>
                      <button
                        onClick={() => removeFile(file.id)}
                        className="p-2 bg-red-500/20 hover:bg-red-500/30 rounded-lg transition-all"
                      >
                        <X className="w-4 h-4" />
                      </button>
                    </div>
                  ))}
                </div>
              )}

              <div className="mt-6">
                <button
                  onClick={() => setShowUploadModal(false)}
                  className="w-full px-6 py-3 bg-gradient-to-br from-pink-400 via-pink-500 to-pink-600 hover:from-pink-500 hover:via-pink-600 hover:to-pink-700 rounded-lg font-semibold shadow-lg transition-all"
                >
                  Done
                </button>
              </div>
            </div>
          </div>
        )}

        <div className="flex justify-between mt-12 max-w-4xl mx-auto">
          {step > 1 && step < 6 && (
            <button
              onClick={() => setStep(step - 1)}
              className="px-6 py-3 bg-white/10 hover:bg-white/20 rounded-lg font-semibold transition-all"
            >
              Previous
            </button>
          )}
          {step < 5 && (
            <button
              onClick={() => setStep(step + 1)}
              disabled={!canProceed()}
              className="ml-auto px-6 py-3 bg-gradient-to-br from-pink-400 via-pink-500 to-pink-600 hover:from-pink-500 hover:via-pink-600 hover:to-pink-700 rounded-lg font-semibold disabled:opacity-50 disabled:cursor-not-allowed shadow-lg transition-all flex items-center gap-2"
            >
              Next
              <ArrowRight className="w-5 h-5" />
            </button>
          )}
        </div>
      </div>
    </div>
  );
};

export default VisivaApp;
