// Some definitions presupposed by pandoc's typst output.
#let blockquote(body) = [
  #set text( size: 0.92em )
  #block(inset: (left: 1.5em, top: 0.2em, bottom: 0.2em))[#body]
]

#let horizontalrule = [
  #line(start: (25%,0%), end: (75%,0%))
]

#let endnote(num, contents) = [
  #stack(dir: ltr, spacing: 3pt, super[#num], contents)
]

#show terms: it => {
  it.children
    .map(child => [
      #strong[#child.term]
      #block(inset: (left: 1.5em, top: -0.4em))[#child.description]
      ])
    .join()
}



#let article(
  title: none,
  authors: none,
  date: none,
  abstract: none,
  cols: 1,
  margin: (x: 1.25in, y: 1.25in),
  paper: "us-letter",
  lang: "en",
  region: "US",
  font: (),
  fontsize: 11pt,
  sectionnumbering: none,
  toc: false,
  doc,
) = {
  set page(
    paper: paper,
    margin: margin,
    numbering: "1",
  )
  set par(justify: true)
  set text(lang: lang,
           region: region,
           font: font,
           size: fontsize)
  set heading(numbering: sectionnumbering)

  if title != none {
    align(center)[#block(inset: 2em)[
      #text(weight: "bold", size: 1.5em)[#title]
    ]]
  }

  if authors != none {
    let count = authors.len()
    let ncols = calc.min(count, 3)
    grid(
      columns: (1fr,) * ncols,
      row-gutter: 1.5em,
      ..authors.map(author =>
          align(center)[
            #author.name \
            #author.affiliation \
            #author.email
          ]
      )
    )
  }

  if date != none {
    align(center)[#block(inset: 1em)[
      #date
    ]]
  }

  if abstract != none {
    block(inset: 2em)[
    #text(weight: "semibold")[Abstract] #h(1em) #abstract
    ]
  }

  if toc {
    block(above: 0em, below: 2em)[
    #outline(
      title: auto,
      depth: none
    );
    ]
  }

  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }
}
#show: doc => article(
  title: [#image("media/logo.png", width: 6.5in) Confidential Neuropsychological Report

],
  margin: (bottom: 72pt,left: 100.8pt,right: 100.8pt,top: 72pt,),
  fontsize: 11pt,
  cols: 1,
  doc,
)


#v(2pt, weak: true)
*Patient Name:* Biggie Smalls\
*Date of Exam:* 2023-01-01
= NEUROBEHAVIORAL STATUS EXAM
<neurobehavioral-status-exam>
== Reason for Referral
<reason-for-referral>
Biggie was referred for neuropsychological testing as part of a comprehensive presurgical work-up of her epilepsy syndrome. The results will be used in surgical and treatment planning.

Biggie is a student at USC referred for evaluation by Dr. Dre to assess her current cognitive and emotional functioning in relation to attention-deficit/hyperactivity disorder (ADHD) and to develop an intervention plan. This report is based on a review of available medical records and information gathered across a 1-hour neurobehavioral exam conducted with the patient via telemedicine on 2023-01-01.

== Measures Administered
<measures-administered>
- Comprehensive Neuropsychiatric Symptom and History Interview
- Conners’ Adult ADHD Diagnostic Interview for DSM-IV (CAADID), Part I: History
- Conners’ Adult ADHD Rating Scales–Self-Report: Long Version (CAARS–S:L)
- Conners’ Adult ADHD Rating Scales–Observer Report: Long Version (CAARS–O:L)
- Comprehensive Executive Function Inventory Adult (CEFI Adult) Self-Report Form
- Comprehensive Executive Function Inventory Adult (CEFI Adult) Observer Form

== Background
<background>
Biggie reports ongoing difficulties with attention/organization and lack of behavioral activation that are making it difficult to finish school, a history of mood dysregulation, performance anxiety, attention/organization problems, and social-emotional difficulties.

== History
<history>
=== Developmental/Medical
<developmentalmedical>
- No birth complicaitons.
- Developmental milestones achieved on time.
- Frequent sinus infections.
- Other medications:
- Appetite/weight: Normal, no changes.
- Sleep: Normal, no changes.
- Alcohol/tobacco: No history of abuse; denied current use.

=== Behavioral/Emotional/Social
<behavioralemotionalsocial>
Biggie reported that she has struggled with depression over the years. She also said that she has always tended to want things a certain way, in a certain order. However, this has not caused problems in daily life. She denied any other anxiety.

Biggie has many friends. She enjoys x, y z.

=== Academics
<academics>
Patient is currently a USC student completing their degree in. Biggie did not endorse any difficulties with advancing through school.

=== Family/Home
<familyhome>
Patient denied a family history of neurological conditions. Her brother was diagnosed with ADHD.

== Prior Testing
<prior-testing>
None indicated.

== Mental Status & Behavioral Observations During Interview
<mental-status-behavioral-observations-during-interview>
Biggie was on time for her examination. She took the meeting from home and was casually dressed and comfortable. She appeared her stated age. She was alert and oriented to person, place, time, and situation. She was able to sustain attention and concentration throughout the interview. She was very articulate with a strong vocabulary, and generally clear thinking processes. There were no signs of aphasia, dysarthria, or anomia. She was able to comprehend and follow verbal instructions. Patient was able to recall recent and remote events without difficulty. There were no signs of amnesia or confabulation. She exhibited normal gross motor functioning with good mobility. Gait and posture are normal. her mood was euthymic and her affect was full in range and expression throughout the interview.

== Summary/Impression
<summaryimpression>
Overall, the current neurobehavioral exam can be used as a starting point for a more comprehensive neuropsychological evaluation. Evaluation will provide an overview of the patient’s cognitive, behavioral, academic, and emotional functioning. Results will help guide further assessment and treatment planning.

=== Diagnostic Considerations
<diagnostic-considerations>
- 314.01 (F90.2) Attention-Deficit/Hyperactivity Disorder (ADHD), Combined Presentation
- #link("03.01_dsm5_icd10_dx.md")[DSM-5/ICD-10 Codes]

== Recommendations/Plan
<recommendationsplan>
+ Proceed with comprehensive neuropsychological and personality assessments;
+ Develop targeted intervention plan and academic plan based on results of testing

#emph[Note:] Evaluation is ongoing. Full report and recommendations to follow.

Please contact me with any questions or concerns regarding this patient.

Neurobehavioral status exam and clinical documentation by Neuropsychologist (96116 x 1, 96121 x 1): 2 hr, 0 min.

#strong[Joey W. Trampush, Ph.D.] \
Assistant Professor of Psychiatry \
Department of Psychiatry and the Behavioral Sciences \
University of Southern California Keck School of Medicine \

#pagebreak()
== Appendix
<appendix>
=== Telemedicine Statement
<telemedicine-statement>
#emph[I connected with the Patient by a video enabled telemedicine application and verified that I am speaking with the correct person using two identifiers. I discussed the limitations of evaluation and management by telemedicine and the availability of in-person appointments. The patient expressed understanding and agreed to proceed. I have verified this to be the correct patient and obtained verbal consent from the patient to perform this voluntary telemedicine visit and evaluation (including obtaining history from the patient). The patient has the right to refuse this evaluation. I have explained risks (including potential loss of confidentiality), benefits, alternatives, and the potential need for subsequent face-to-face care. The patient understands that there is a risk of medical inaccuracies given that our recommendations will be made based on reported data (and we must therefore assume this information is accurate). Knowing that there is a risk that this information is not reported accurately, and that the telemedicine video, audio, or data feed may be incomplete, the patient agrees to proceed with evaluation and holds Keck Medicine of USC harmless knowing these risks. I have notified the patient that other healthcare professionals (including students, residents, and technical personnel) may be involved in this audio-video evaluation. All laws concerning medical records apply to telemedicine. The patient has received the Keck Medicine of USC Notice of Privacy Practices.]

#pagebreak()
=== CAARS Adult ADHD Rating Scales
<caars-adult-adhd-rating-scales>
<tbl-caars-sr>
#strong[?(caption)]

<tbl-caars-or>
#strong[?(caption)]

#pagebreak()
=== CEFI Executive Functioning Rating Scales
<cefi-executive-functioning-rating-scales>
<tbl-cefi-sr>
<tbl-cefi-or>



#bibliography("bwu.bib")

